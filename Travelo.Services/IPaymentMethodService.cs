using System;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
	public interface IPaymentMethodService : ICRUDService<Model.PaymentMethod, PaymentMethodSearchObject, PaymentMethodCreateUpdateRequest, PaymentMethodCreateUpdateRequest>
    {
	}
}

