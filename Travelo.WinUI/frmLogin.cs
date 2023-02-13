using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Travelo.WinUI
{
    public partial class frmLogin : Form
    {

        private readonly APIService Service = new APIService("Agency");

        public frmLogin()
        {
            InitializeComponent();
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {

        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            if(ValidateChildren())
            {
                APIService.Email = inputEmail.Text;
                APIService.Password = inputPassword.Text;

                try
                {
                    var result = await Service.Get<dynamic>();
                    frmDashboard frm = new frmDashboard();
                    frm.Show();
                    Hide();

                }
                catch (Exception ex)
                {
                    MessageBox.Show("Wrong username or password");
                }
            }

            

        }

        private void inputUsername_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {
            frmRegister frm = new frmRegister();
            frm.Show();
            Hide();
        }

        private void inputEmail_Validating(object sender, CancelEventArgs e)
        {
            if(string.IsNullOrWhiteSpace(inputEmail.Text))
            {
                e.Cancel = true;
                inputEmail.Focus();
                errorProvider.SetError(inputEmail, "Email should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(inputEmail, "");
            }
        }

        private void inputPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(inputPassword.Text))
            {
                e.Cancel = true;
                inputPassword.Focus();
                errorProvider.SetError(inputPassword, "Password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(inputPassword, "");
            }
        }
    }
}
