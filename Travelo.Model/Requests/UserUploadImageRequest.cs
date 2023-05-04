using System;
namespace Travelo.Model.Requests
{
	public class UserUploadImageRequest
	{
		public int  UserId { get; set; }
        public byte[] Image { get; set; }
    }
}

