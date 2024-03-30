using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape.DesmondsPage
{

    public partial class Login : System.Web.UI.Page
    {
        protected void BtnSignIn_Click(object sender, EventArgs e)
        {
            string input = txtMailNum.Text.Trim();
            string password = txtPassword.Text;
            string hashedInput = Convert.ToBase64String(System.Security.Cryptography.SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(password)));

            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True"))
            {
                con.Open();

                string query = "SELECT 'Customer' AS userType, custEmail, custPhoneNumber FROM Customer WHERE (custEmail = @login OR custPhoneNumber = @login) AND custPassword = @password";
                string queryHost = "SELECT 'Host' AS userType, hostEmail, hostPhoneNumber FROM Host WHERE (hostEmail = @login OR hostPhoneNumber = @login) AND hostPassword = @password";


                using (SqlCommand cmd = new SqlCommand(query + " UNION ALL " + queryHost, con))
                {
                    cmd.Parameters.AddWithValue("@login", input);
                    cmd.Parameters.AddWithValue("@password", hashedInput);

                    // Debug.WriteLine("Query: " + cmd.CommandText + "; @login = " + input + "; @password = " + hashedInput);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        bool redirectToProfile = false;
                        bool redirectToHostCheck = false;

                        if (dt.Rows.Count > 0)
                        {
                            string userType = dt.Rows[0]["userType"].ToString();

                            if (userType == "Customer")
                            {
                                Debug.WriteLine("User is in Customer role.");
                                // Store phone number in session for later use
                                Session["phoneNumber"] = dt.Rows[0]["custPhoneNumber"].ToString();
                                redirectToProfile = true;
                            }
                            else if (userType == "Host")
                            {
                                Debug.WriteLine("User is in Host role.");
                                // Store phone number in session for later use
                                // Session["phoneNumber"] = dt.Rows[0]["hostPhoneNumber"].ToString();
                                foreach (DataRow row in dt.Rows)
                                {
                                    Console.WriteLine("Host Email: " + row["hostEmail"]);
                                    Console.WriteLine("Host Phone Number: " + row["hostPhoneNumber"]);
                                }
                                redirectToHostCheck = true;
                            }
                            else
                            {
                                Debug.WriteLine("User is not in any role.");
                                // Handle the case where the user is not in any role
                                Response.Write("User is not in any role.");
                            }
                        }
                        else
                        {
                            Debug.WriteLine("No rows returned from query.");
                            // Handle the case where no rows were returned from the query
                            Response.Write("Invalid credentials.");
                        }

                        // Redirect based on the role
                        if (redirectToProfile)
                        {
                            Debug.WriteLine("Redirecting to Profile.aspx");
                            Response.Redirect("Profile.aspx");
                        }
                        else if (redirectToHostCheck)
                        {
                            Debug.WriteLine("Redirecting to HostCheck.aspx");
                            Response.Redirect("HostCheck.aspx");
                        }



                    }
                }
            }
        }

    }
}
