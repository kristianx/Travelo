using EasyNetQ;
using MailingService;
using Travelo.Model;

namespace MailService;

public class Worker : BackgroundService
{
    private readonly ILogger<Worker> _logger;
    private readonly IEmailSender _emailSender;

    private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
    private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
    private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
    private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

    public Worker(ILogger<Worker> logger, IEmailSender emailSender)
    {
        _logger = logger;
        _emailSender = emailSender;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        using (var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}"))
        {
            bus.PubSub.Subscribe<IEnumerable<Tag>>("New_Reservations", HandleMessageAsync);
            Console.WriteLine("Listening for reservations.");
        }
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

