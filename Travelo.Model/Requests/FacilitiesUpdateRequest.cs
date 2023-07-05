using System;
using System.Collections.Generic;

namespace Travelo.Model.Requests
{
	public class FacilitiesUpdateRequest
	{
		public int AccomodationId { get; set; }
		public List<string> facilities { get; set; }
	}
}

