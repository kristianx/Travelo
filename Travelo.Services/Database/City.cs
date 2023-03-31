using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.Services.Database
{
    public class City
    {
        public City() {

            this.Tags = new HashSet<Tag>();
        }

        [Key]
        public int Id { get; set; }
        public string Name { get; set; }

        public int CountryId { get; set; }
        public virtual Country Country { get; set; }

        public virtual ICollection<Tag> Tags { get; set; }

        public byte[]? Image { get; set; }

    }
}
