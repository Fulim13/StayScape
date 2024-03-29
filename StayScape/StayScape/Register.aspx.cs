using System;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;

namespace StayScape.DesmondsPage
{

    public partial class Register : System.Web.UI.Page
    {
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("@Data Source=(LocalDB)\\MSSQLLocalDB");
            {
                con.Open();

                SqlCommand regisCmd = new SqlCommand("INSERT INTO CUSTOMER VALUES(@customerName, @custPhoneNumber, @custEmail, @custPassword, @birthDate, @gender)", con);
                regisCmd.Parameters.AddWithValue("customerName", txtName);
                regisCmd.Parameters.AddWithValue("custPhoneNumber", txtPhone);
                regisCmd.Parameters.AddWithValue("custEmail", txtEmail);
                regisCmd.Parameters.AddWithValue("custPassword", txtPassword);
                regisCmd.Parameters.AddWithValue("birthDate", txtbDate);
                regisCmd.Parameters.AddWithValue("gender", genderDropdown.SelectedValue);
                regisCmd.ExecuteNonQuery();
            }
        }
    }
}
