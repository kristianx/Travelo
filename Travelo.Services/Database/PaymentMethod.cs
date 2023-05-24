using System;
using System.ComponentModel.DataAnnotations;

namespace Travelo.Services.Database
{
	public class PaymentMethod
	{
		public PaymentMethod()
		{
		}
		[Key]
		public int Id { get; set; }
        public int CardType { get; set; }
        public string CardNumber { get; set; }
		public string LastDigits { get; set; }
		public string HolderName { get; set; }
		public string Address { get; set; }
		public string CVV { get; set; }
		public string ExpDate { get; set; }
    }
}

