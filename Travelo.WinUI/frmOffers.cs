using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Flurl;
using Flurl.Http;
using Travelo.Model;

namespace Travelo.WinUI
{ 
    public partial class frmOffers : Form
    {
        public APIService Service { get; set; } = new APIService("User");
        public frmOffers()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            var entity = await Service.GetById<User>(7);
            entity.FirstName = "Dobrivojey";
            var updated = await Service.Put<User>(7, entity);

        }
    }
} 
