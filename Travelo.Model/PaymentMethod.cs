using System;
namespace Travelo.Model
{
	public partial class PaymentMethod
	{
        public int Id { get; set; }
        public string CardNumber { get; set; }
        public string HolderName { get; set; }
        public string Address { get; set; }
        public string CVV { get; set; }
        public string ExpDate { get; set; }
        public string CardType { get; set; }
        public string LastDigits { get; set; }
    }
}

