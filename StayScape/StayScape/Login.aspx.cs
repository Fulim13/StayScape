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
                MembershipUser user = Membership.GetUser(email);
                Guid userId = (Guid)user.ProviderUserKey;

                Session["UserId"] = userId;

                // Debug.WriteLine(userId);

                if (Roles.IsUserInRole(email, "Host"))
                {
                    FormsAuthentication.SetAuthCookie(email, false);
                    Response.Redirect("Dashboard.aspx"); //<-- replace this with actual host page
                }
                else
                {
                    FormsAuthentication.RedirectFromLoginPage(email, false);
                    // Response.Redirect("Profile.aspx");
                }
            }
            else
            {
                LoginCheck.Text = "Invalid credentials.";
            }
        }

    }
}
