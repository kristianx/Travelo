
using EasyNetQ;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Text;
using Travelo.Model;



//var subscriptionId = "default";
//Console.WriteLine("Provide subscriptionid: ");
//subscriptionId = Console.ReadLine();

var host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
var username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
var password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
var virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

Console.WriteLine(host);
Console.WriteLine(username);
Console.WriteLine(password);
Console.WriteLine(virtualhost);









