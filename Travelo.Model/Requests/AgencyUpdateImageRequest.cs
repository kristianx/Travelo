using System;
namespace Travelo.Model.Requests
{
	public class AgencyUpdateImageRequest
	{
		public int AgencyId { get; set; }
        public byte[] Image { get; set; }
    }
}

