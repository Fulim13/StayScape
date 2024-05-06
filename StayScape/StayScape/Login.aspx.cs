using System;
using System.Diagnostics;
using System.Web.Security;

namespace StayScape.DesmondsPage
{

    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void BtnSignIn_Click(object sender, EventArgs e)
        {
            string email = txtMail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validate the user using email
            if (Membership.ValidateUser(email, password))
            {
                if (Roles.IsUserInRole(email, "Host"))
                {
                    // Set authentication cookie with expiration set to "Session"
                    FormsAuthentication.SetAuthCookie(email, false);

                    // Redirect to the dashboard or host page
                    Response.Redirect("Dashboard.aspx"); //<-- replace this with actual host page
                }
                else
                {
                    // Set authentication cookie with expiration set to "Session"
                    FormsAuthentication.SetAuthCookie(email, false);

                    // Redirect to the default page or the requested page
                    FormsAuthentication.RedirectFromLoginPage(email, false);
                }
            }
            else
            {
                LoginCheck.Text = "Invalid credentials.";
            }
        }

    }
}
