using System;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Travelo.Model;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;
using Travelo.Services;

namespace Travelo.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class TagController : BaseCRUDController<Model.Tag, TagSearchObject, TagCreateUpdateRequest, TagCreateUpdateRequest>
    {
        private readonly IMessageProducer _messageProducer;
        public TagController(ITagService service, IMessageProducer messageProducer) : base(service)
        {
            _messageProducer = messageProducer;
        }
        public override IEnumerable<Tag> Get([FromQuery] TagSearchObject search = null)
        {
            return base.Get(search);
        }
    }
}

