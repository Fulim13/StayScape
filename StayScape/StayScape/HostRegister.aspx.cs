using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
                string userID = GenerateRandomID(64);
                string password = txtPassword.Text;
                string hashedPassword = Convert.ToBase64String(System.Security.Cryptography.SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(password)));

                SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True");
                {
                    con.Open();

                    SqlCommand regisCmd = new SqlCommand("INSERT INTO HOST (hostID, hostName, hostPhoneNumber, hostEmail, hostPassword, birthDate, gender, createdAt) VALUES (@hostID, @hostName, @hostPhoneNumber, @hostEmail, @hostPassword, @birthDate, @gender, @createdAt)", con);
                    regisCmd.Parameters.AddWithValue("@hostID", userID);
                    regisCmd.Parameters.AddWithValue("@hostName", txtName.Text);
                    regisCmd.Parameters.AddWithValue("@hostPhoneNumber", txtPhone.Text);
                    regisCmd.Parameters.AddWithValue("@hostEmail", txtEmail.Text);
                    regisCmd.Parameters.AddWithValue("@hostPassword", hashedPassword);
                    regisCmd.Parameters.AddWithValue("@birthDate", txtbDate.Text);
                    regisCmd.Parameters.AddWithValue("@gender", genderDropdown.SelectedValue);
                    regisCmd.Parameters.AddWithValue("@createdAt", DateTime.Now);
                    regisCmd.ExecuteNonQuery();

                    Roles.AddUserToRole(userID, "Host");

                    Response.Redirect("Login.aspx");
                }
            }
        }

        private string GenerateRandomID(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            StringBuilder sb = new StringBuilder();
            Random random = new Random();

            for (int i = 0; i < length; i++)
            {
                sb.Append(chars[random.Next(chars.Length)]);
            }

            return sb.ToString();
        }
    }
}