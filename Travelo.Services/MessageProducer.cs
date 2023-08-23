using System;
using RabbitMQ.Client;
using System.Text;

namespace Travelo.Services
{
	public class MessageProducer : IMessageProducer
	{
		public MessageProducer()
		{
		}

        public void SendingMessage(string message)
        {
            try
            {

                var factory = new ConnectionFactory {
                    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq",
                    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user",
                    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass",
                    VirtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/",
                };

                using var connection = factory.CreateConnection();
                using var channel = connection.CreateModel();

                channel.QueueDeclare(queue: "trip_notifications",
                                     durable: true,
                                     exclusive: true
                                  );


                var body = Encoding.UTF8.GetBytes(message);

                channel.BasicPublish(exchange: string.Empty,
                                     routingKey: "trip_added",
                                     basicProperties: null,
                                     body: body);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"An error occurred while sending message to RabbitMQ: {ex.Message}");

            }
        }
    }
}

