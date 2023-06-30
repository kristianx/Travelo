using System;
using System.ComponentModel.DataAnnotations;

namespace Travelo.Services.Database
{
	public class PaymentMethod
	{
		[Key]
		public int Id { get; set; }
        public string CardNumber { get; set; }
		public string HolderName { get; set; }
		public string Address { get; set; }
		public string CVV { get; set; }
		public string ExpDate { get; set; }
		public bool Primary { get; set; } = false;

		public string CardType => "VISA";
		public string LastDigits  => CardNumber.Substring(CardNumber.Length - 4);

        public int UserId { get; set; }
        public User User { get; set; }
    }
}

