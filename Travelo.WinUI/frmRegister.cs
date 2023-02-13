using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Travelo.Model;
using Travelo.Model.Requests;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Travelo.WinUI
{
    public partial class frmRegister : Form
    {
        private readonly APIService CityService = new APIService("City");
        private readonly APIService AgencyService = new APIService("Agency");
        public class CityItem
        {
            public int Id { set; get; }
            public string Name { set; get; }

        }
        public frmRegister()
        {
            InitializeComponent();

            onLoad();


            //foreach (var city in cities)
            //{
            //    list.Add(
            //        new CityItem()
            //        {
            //            Id = city.Id,
            //            Name = city.Name
            //        })
            //}


           
        }
        public async void  onLoad()
        {
            var cities = await CityService.Get<List<Model.City>>();


            var list = new List<CityItem>();
            //list.Add(new CityItem() { Id = 1, Name = "Mostar" });
            //list.Add(new CityItem() { Id = 2, Name = "Zivinice" });


            foreach (Model.City c in cities)
            {
                list.Add(new CityItem() { Id = c.Id, Name = c.Name });
            }

            CitySelector.DataSource = list;
            CitySelector.DisplayMember = "Name";
            CitySelector.ValueMember = "Id";
        }
        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private async void comboBox1_SelectedIndexChanged_1(object sender, EventArgs e)
        {
   

        }
 
        private void btnRegister_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {
            frmLogin frm = new frmLogin();
            frm.Show();
            Hide();
        }
        private async void frmRegister_Load(object sender, EventArgs e)
        {
          
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private async void btnRegister_Click_1(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                var AgencyCreate = new AgencyCreateUpdateRequest()
                {
                    Name = txtName.Text,
                    Email = txtEmail.Text,
                    Password = txtPassword.Text,
                    ConfirmPassword = txtPasswordConfirm.Text,
                    WebsiteUrl = txtWebsite.Text,
                    Phone = txtPhone.Text,
                    About = txtAbout.Text,
                    Address = txtAddress.Text,
                    PostalCode = txtPostalCode.Text,
                    CityId = (int)CitySelector.SelectedValue
                };

                try
                {
                    var agency = await AgencyService.Post<AgencyCreateUpdateRequest>(AgencyCreate);
                    frmDashboard dash = new frmDashboard();
                    dash.Show();
                    Hide();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Wrong something");
                }
            }
         
            
        }

        private void label2_Click_1(object sender, EventArgs e)
        {
            frmLogin frm = new frmLogin();
            frm.Show();
            Hide();
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                e.Cancel = true;
                txtEmail.Focus();
                errorProvider.SetError(txtEmail, "Email should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtEmail, "");
            }
        }

        private void txtName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                e.Cancel = true;
                txtName.Focus();
                errorProvider.SetError(txtName, "Agency name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtName, "");
            }
            
            
        }
        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                e.Cancel = true;
                txtPassword.Focus();
                errorProvider.SetError(txtPassword, "Password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtPassword, "");
            }
        }
        private void txtPasswordConfirm_Validating(object sender, CancelEventArgs e)
        {
            
            if (string.IsNullOrWhiteSpace(txtPasswordConfirm.Text))
            {
                e.Cancel = true;
                txtPasswordConfirm.Focus();
                errorProvider.SetError(txtPasswordConfirm, "Password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtPasswordConfirm, "");
            }
        }
        private void txtAddress_Validating(object sender, CancelEventArgs e)
        {
            

            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                e.Cancel = true;
                txtAddress.Focus();
                errorProvider.SetError(txtAddress, "Address should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtAddress, "");
            }
        }


        private void frmRegister_Load_1(object sender, EventArgs e)
        {

        }
    }
}
