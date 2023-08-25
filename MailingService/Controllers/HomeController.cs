using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using MailingService.Models;
using EasyNetQ;
using RabbitMQ.Client;

namespace MailingService.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IEmailSender _emailSender;

    public HomeController(ILogger<HomeController> logger, IEmailSender emailSender)
    {
        _logger = logger;
        _emailSender = emailSender;
    }

    [HttpPost]
    public async Task<IActionResult> Index(string email, string subject, string message)
    {
        return View();
    }

    public async Task<IActionResult> Index()
    {
        
        var receiver = new ReservationSubscriber(_emailSender);
        receiver.ReceiveReservation();
        return View();
    }

 


    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}

