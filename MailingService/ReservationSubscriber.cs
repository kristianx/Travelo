using System;
using System.Text;
using EasyNetQ;
using Microsoft.Extensions.Hosting;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using Travelo.Model;

namespace MailingService
{
	public class ReservationSubscriber
	{
        private readonly IEmailSender _emailSender;
        public ReservationSubscriber(IEmailSender emailSender)
		{
            _emailSender = emailSender;

        }

        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public void ReceiveMessage()
        {
            var factory = new ConnectionFactory
            {
                HostName = _host,
                UserName = _username,
                Password = _password
            };

            using var connection = factory.CreateConnection();
            using (var channel = connection.CreateModel())
            {
                channel.QueueDeclare(queue: "Reservation_added",
                                     durable: false,
                                     exclusive: false,
                                     autoDelete: false,
                                     arguments: null);

                var consumer = new EventingBasicConsumer(channel);
                consumer.Received += (model, ea) =>
                {
                    var body = ea.Body.ToArray();
                    var message = Encoding.UTF8.GetString(body);
                    Console.WriteLine("Received message: {0}", message);
                };
                channel.BasicConsume(queue: "Reservation_added",
                                     autoAck: true,
                                     consumer: consumer);
            }
     
        }
        public void ReceiveReservation()
        {
            //try
            //{
                using (var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}"))
                {
                    bus.PubSub.Subscribe<IEnumerable<Tag>>("New_Reservations", HandleMessageAsync);
                    Console.WriteLine("Listening for reservations.");
                }
            //}
            //catch (Exception ex)
            //{
            //    Console.WriteLine($"An error occurred: {ex.Message}");
               
            //}


        }
        async Task HandleMessageAsync(IEnumerable<Tag> reservation)
        {
            var stringz = "";

            foreach (Tag res in reservation)
            {
                stringz += $", {res.Name}";
                Console.WriteLine($"Received new reservation: {res?.Id}, {res?.Name}");
            }
            await _emailSender.SendEmailAsync("cestdev@gmail.com", "Testiram malo", stringz);
        }
    }
}

