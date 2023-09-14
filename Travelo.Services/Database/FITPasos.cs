using System;
namespace Travelo.Services.Database
{
	public class FITPasos
	{
		public FITPasos()
		{
		}
        public int Id { get; set; }
        public DateTime DateIssued { get; set; }

		public int UserId { get; set; }
        public User User { get; set; }

		public bool Valid { get; set; }
    }
}

