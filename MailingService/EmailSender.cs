using System;
using System.Net;
using System.Net.Mail;


namespace MailingService
{
	public class EmailSender : IEmailSender
	{
		public EmailSender()
		{
		}

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential("travelo-reservations@outlook.com", "Travelo-pass123")
            };

            return client.SendMailAsync(
                new MailMessage(from: "travelo-reservations@outlook.com",
                                to: email,
                                subject,
                                message
                                ));

        }
    }
}

