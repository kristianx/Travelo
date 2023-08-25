using MailingService;
using MailService;

IHost host = Host.CreateDefaultBuilder(args)
    .ConfigureServices(services =>
    {
        services.AddHostedService<Worker>();
        services.AddTransient<IEmailSender, EmailSender>();
    })
    .Build();

await host.RunAsync();

