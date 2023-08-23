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
        private readonly IMessageProducer _message;
        public TagController(ITagService service, IMessageProducer messageProducer) : base(service)
        {
            _message = messageProducer;
        }
        public override IEnumerable<Tag> Get([FromQuery] TagSearchObject search = null)
        {
            _message.SendingMessage("Hey ho");
            return base.Get(search);
        }
    }
}

