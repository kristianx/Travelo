using System;
namespace Travelo.Model.Requests
{
	public class AccommodationUpdateImageRequest
	{
		public int AccomodationId { get; set; }
		public byte[] Image { get; set; }
	
	}
}

