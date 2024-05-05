using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class HostRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Roles.RoleExists("Host"))
            {
                // Create the role if it doesn't exist
                Roles.CreateRole("Host");
            }
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Page.Validate("Registration");
            if (Page.IsValid)
            {
                // Create a new user
                MembershipCreateStatus status;
                MembershipUser newUser = null;
                try
                {
                    newUser = Membership.CreateUser(txtEmail.Text, txtPassword.Text, txtEmail.Text, null, null, true, out status);

                    Debug.WriteLine("MembershipCreateStatus: " + status.ToString());

                    if (status == MembershipCreateStatus.Success)
                    {
                        // User created successfully
                        Guid userId = (Guid)newUser.ProviderUserKey;

                        // Insert user details into the HOST table
                        using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\StayScapeDB.mdf;Integrated Security=True"))
                        {
                            con.Open();

                            SqlCommand regisCmd = new SqlCommand("INSERT INTO HOST (hostID, hostName, hostPhoneNumber, hostEmail, birthDate, gender, createdAt) VALUES (@hostID, @hostName, @hostPhoneNumber, @hostEmail, @birthDate, @gender, @createdAt)", con);
                            regisCmd.Parameters.AddWithValue("@hostID", userId);
                            regisCmd.Parameters.AddWithValue("@hostName", txtName.Text);
                            regisCmd.Parameters.AddWithValue("@hostPhoneNumber", txtPhone.Text);
                            regisCmd.Parameters.AddWithValue("@hostEmail", txtEmail.Text);
                            regisCmd.Parameters.AddWithValue("@birthDate", txtbDate.Text);
                            regisCmd.Parameters.AddWithValue("@gender", genderDropdown.SelectedValue);
                            regisCmd.Parameters.AddWithValue("@createdAt", DateTime.Now);
                            regisCmd.ExecuteNonQuery();
                        }

                        Roles.AddUserToRole(newUser.UserName, "Host");

                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        // Log the status and any other relevant information
                        Debug.WriteLine("User creation failed: " + status.ToString());
                        // Handle the failure according to the status
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception
                    Debug.WriteLine("Exception: " + ex.Message);
                    // Handle the exception
                }
            }
        }
    }
}