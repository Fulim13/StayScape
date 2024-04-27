using System;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Text;
using System.Web.Security;
using System.Diagnostics;

namespace StayScape.DesmondsPage
{

    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Roles.RoleExists("Customer"))
            {
                // Create the role if it doesn't exist
                Roles.CreateRole("Customer");
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

                        // Insert user details into the CUSTOMER table
                        using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True"))
                        {
                            con.Open();

                            SqlCommand regisCmd = new SqlCommand("INSERT INTO CUSTOMER (custID, customerName, custPhoneNumber, custEmail, birthDate, gender, createdAt) VALUES (@custID, @customerName, @custPhoneNumber, @custEmail, @birthDate, @gender, @createdAt)", con);
                            regisCmd.Parameters.AddWithValue("@custID", userId);
                            regisCmd.Parameters.AddWithValue("@customerName", txtName.Text);
                            regisCmd.Parameters.AddWithValue("@custPhoneNumber", txtPhone.Text);
                            regisCmd.Parameters.AddWithValue("@custEmail", txtEmail.Text);
                            regisCmd.Parameters.AddWithValue("@birthDate", txtbDate.Text);
                            regisCmd.Parameters.AddWithValue("@gender", genderDropdown.SelectedValue);
                            regisCmd.Parameters.AddWithValue("@createdAt", DateTime.Now);
                            regisCmd.ExecuteNonQuery();
                        }

                        Roles.AddUserToRole(newUser.UserName, "Customer");

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
