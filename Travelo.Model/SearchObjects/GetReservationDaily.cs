using System;
namespace Travelo.Model.SearchObjects
{
	public class GetReservationDaily : BaseSearchObject
    {
	
        public int Year { get; set; }
        public int Month { get; set; }
        public int AgencyId { get; set; }
    }
}

