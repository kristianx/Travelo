using System;
using AutoMapper;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services.Database;

namespace Travelo.Services
{
    public class PaymentMethodService : BaseCRUDService<Model.PaymentMethod, Database.PaymentMethod, PaymentMethodSearchObject, PaymentMethodCreateUpdateRequest, PaymentMethodCreateUpdateRequest>, IPaymentMethodService
    {
        public PaymentMethodService(TraveloContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<PaymentMethod> AddFilter(IQueryable<PaymentMethod> query, PaymentMethodSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.UserId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.UserId == search.UserId);
            }

          
            return filteredQuery;
        }
    }
}

