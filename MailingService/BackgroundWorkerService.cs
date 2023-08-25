using System.Text;
using MailingService;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

public class ConsumeRabbitMQHostedService : BackgroundService
{
    private readonly ILogger _logger;
    private IConnection _connection;
    private IModel _channel;
    private readonly IEmailSender _emailSender;

    private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
    private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
    private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
    private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

    public ConsumeRabbitMQHostedService(ILoggerFactory loggerFactory, IEmailSender emailSender)
    {
        this._logger = loggerFactory.CreateLogger<ConsumeRabbitMQHostedService>();
        _emailSender = emailSender;
        InitRabbitMQ();
    }

    private void InitRabbitMQ()
    {
        var factory = new ConnectionFactory
        {
            HostName = _host,
            UserName = _username,
            Password = _password
        };

        // create connection  
        _connection = factory.CreateConnection();

        // create channel  
        _channel = _connection.CreateModel();

        //_channel.ExchangeDeclare("demo.exchange", ExchangeType.Topic);
        _channel.QueueDeclare("Reservation_added", false, false, false, null);
        //_channel.QueueBind("demo.queue.log", "demo.exchange", "demo.queue.*", null);
        _channel.BasicQos(0, 1, false);

        _connection.ConnectionShutdown += RabbitMQ_ConnectionShutdown;
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        stoppingToken.ThrowIfCancellationRequested();

        var consumer = new EventingBasicConsumer(_channel);
        consumer.Received += (ch, ea) =>
        {
            // received message  
       
            var body = ea.Body.ToArray();
            // handle the received message
            var message = Encoding.UTF8.GetString(body);
            HandleMessageAsync(message);
            _channel.BasicAck(ea.DeliveryTag, false);
        };

        consumer.Shutdown += OnConsumerShutdown;
        consumer.Registered += OnConsumerRegistered;
        consumer.Unregistered += OnConsumerUnregistered;
        consumer.ConsumerCancelled += OnConsumerConsumerCancelled;

        _channel.BasicConsume("Reservation_added", false, consumer);
        _logger.LogInformation("Working!");
        return Task.CompletedTask;
    }

    private async Task HandleMessageAsync(string content)
    {
        // we just print this message   
        _logger.LogInformation($"consumer received {content}");
        await _emailSender.SendEmailAsync("cestdev@gmail.com", "Testiram malo", "Heyyy");

    }

    private void OnConsumerConsumerCancelled(object sender, ConsumerEventArgs e) { }
    private void OnConsumerUnregistered(object sender, ConsumerEventArgs e) { }
    private void OnConsumerRegistered(object sender, ConsumerEventArgs e) { }
    private void OnConsumerShutdown(object sender, ShutdownEventArgs e) { }
    private void RabbitMQ_ConnectionShutdown(object sender, ShutdownEventArgs e) { }

    public override void Dispose()
    {
        _channel.Close();
        _connection.Close();
        base.Dispose();
    }
}



//using System;
//using EasyNetQ;
//using System.Xml.Linq;
//using RabbitMQ.Client;
//using RabbitMQ.Client.Events;

//namespace MailingService
//{
//    public class Worker : BackgroundService
//    {
//        private readonly ILogger<Worker> _logger;
//        private readonly IEmailSender _emailSender;

//        public Worker(ILogger<Worker> logger, IEmailSender emailSender)
//        {
//            _logger = logger;
//            _emailSender = emailSender;
//        }

//        //public Task StartAsync(CancellationToken cancellationToken)
//        //{
//        //    _logger.LogInformation("Service started.");

//        //    var receiver = new ReservationSubscriber(_emailSender);

//        //    receiver.ReceiveReservation();

//        //    return Task.CompletedTask;
//        //}

//        //public Task StopAsync(CancellationToken cancellationToken)
//        //{
//        //    throw new NotImplementedException();
//        //}

//        protected override async Task<Task> ExecuteAsync(CancellationToken stoppingToken)
//        {

//            _logger.LogInformation("Hosted service starting");

//            while (true)
//            {
//                var receiver = new ReservationSubscriber(_emailSender);

//                receiver.ReceiveReservation();

//                await Task.Delay(999999999, stoppingToken);
//            }


//            //stoppingToken.ThrowIfCancellationRequested();

//            //_logger.LogInformation("Service started.");

//            //var receiver = new ReservationSubscriber(_emailSender);

//            //receiver.ReceiveReservation();

//            //return Task.CompletedTask;
//        }
//    }
//}

