using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using MailingService.Models;
using EasyNetQ;
using RabbitMQ.Client;

namespace MailingService.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;


    public HomeController(ILogger<HomeController> logger, IEmailSender emailSender)
    {
        _logger = logger;
 
    }

    public async Task<IActionResult> Index()
    {
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

