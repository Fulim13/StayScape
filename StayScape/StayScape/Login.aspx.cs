using System;
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
                MembershipUser user = Membership.GetUser(email);
                Guid userId = (Guid)user.ProviderUserKey;

                if (Roles.IsUserInRole(email, "Host"))
                {
                    // Set authentication cookie with expiration set to "Session"
                    FormsAuthentication.SetAuthCookie(email, false);
                    Session["hostID"] = userId.ToString().ToUpper();
                    // Redirect to the dashboard or host page
                    Response.Redirect("Host/Dashboard.aspx"); //<-- replace this with actual host page
                }
                else
                {
                    // Check if the user was previously authenticated as a host
                    if (Roles.IsUserInRole(email, "Host"))
                    {
                        // If so, remove the host-specific session variable
                        Session.Remove("hostID");
                    }

                    // Set authentication cookie with expiration set to "Session"
                    FormsAuthentication.SetAuthCookie(email, false);
                    Session["custID"] = userId.ToString().ToUpper();
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
