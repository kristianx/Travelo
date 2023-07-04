using System;
namespace Travelo.Model.Requests
{
	public class AccomodationUpdateImageRequest
	{
		public int AccomodationId { get; set; }
		public byte[] Image { get; set; }
	
	}
}

