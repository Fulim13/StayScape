using System;
using System.Web;
using System.Web.UI;

namespace StayScape.DesmondsPage
{

    public partial class Login : System.Web.UI.Page
    {
        protected void BtnSignIn_Click(object sender, EventArgs e)
        {
            string emailNum = txtMailNum.Text;
            string password = txtPassword.Text;

            bool isValid = ValidateUser(emailNum, password);

            if (isValid)
            {
                Session["LoggedIn"] = emailNum;

                Response.Redirect("Profile.aspx");
            }
            else
            {
                // logged in failed
            }
        }

        private bool ValidateUser(string emailNum, string password)
        {
            //logic here, otherwise, always true
            return true;
        }
    }
}
