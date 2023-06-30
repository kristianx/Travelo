using System;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PaymentMethodController : BaseCRUDController<Model.PaymentMethod, PaymentMethodSearchObject, PaymentMethodCreateUpdateRequest, PaymentMethodCreateUpdateRequest>
    {
        IPaymentMethodService _service;
        public PaymentMethodController(IPaymentMethodService service) : base(service)
        {
            _service = service;
        }
    }
}

