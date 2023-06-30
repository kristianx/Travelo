using System;
using Travelo.Model.Requests;
using Travelo.Model.SearchObjects;

namespace Travelo.Services
{
	public interface ITagService : ICRUDService<Model.Tag, TagSearchObject, TagCreateUpdateRequest, TagCreateUpdateRequest>
    {
	}
}

