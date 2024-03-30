using System;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Text;
using System.Web.Security;

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
            string userID = GenerateRandomID(64);
            string password = txtPassword.Text;
            string hashedPassword = Convert.ToBase64String(System.Security.Cryptography.SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(password)));

            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True");
            {
                con.Open();

                SqlCommand regisCmd = new SqlCommand("INSERT INTO CUSTOMER (custID, customerName, custPhoneNumber, custEmail, custPassword, birthDate, gender, createdAt) VALUES (@custID, @customerName, @custPhoneNumber, @custEmail, @custPassword, @birthDate, @gender, @createdAt)", con);
                regisCmd.Parameters.AddWithValue("@custID", userID);
                regisCmd.Parameters.AddWithValue("@customerName", txtName.Text);
                regisCmd.Parameters.AddWithValue("@custPhoneNumber", txtPhone.Text);
                regisCmd.Parameters.AddWithValue("@custEmail", txtEmail.Text);
                regisCmd.Parameters.AddWithValue("@custPassword", hashedPassword);
                regisCmd.Parameters.AddWithValue("@birthDate", txtbDate.Text);
                regisCmd.Parameters.AddWithValue("@gender", genderDropdown.SelectedValue);
                regisCmd.Parameters.AddWithValue("@createdAt", DateTime.Now);
                regisCmd.ExecuteNonQuery();

                Roles.AddUserToRole(userID, "Customer");

                Response.Redirect("Login.aspx");
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
