using Microsoft.VisualBasic.ApplicationServices;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class Customer : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve user email instead since i cant retrieve id, will see what to do later
                string userId = HttpContext.Current.User.Identity.Name;

                // Retrieve image data from the database
                byte[] imageData = GetImageDataFromDatabase(userId);

                if (imageData != null && imageData.Length > 0)
                {
                    // Convert image data to a base64 string
                    string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                    string imageUrl = "data:image/jpeg;base64," + base64String;

                    // Set the src attribute of the img tag to the base64 image data
                    imgProfilePicture.ImageUrl = imageUrl;
                    Debug.WriteLine("image exists");
                }
                else
                {
                    // Set a default image if no image data is found in the database
                    imgProfilePicture.ImageUrl = "~/Images/newuser.jpg";
                    Debug.WriteLine("image does not exist");
                }
            }
        }

        private byte[] GetImageDataFromDatabase(string userId)
        {
            string query = "";
            byte[] result = null;

            // Check if the user is a host
            query = "SELECT hostProfilePic FROM Host WHERE hostEmail = @userId";
            result = GetImageDataFromQuery(query, userId);

            // If no result from host, check if the user is a customer
            if (result == null)
            {
                query = "SELECT custProfilePic FROM Customer WHERE custEmail = @userId";
                result = GetImageDataFromQuery(query, userId);
            }

            return result;
        }

        private byte[] GetImageDataFromQuery(string query, string userId)
        {
            byte[] result = null;

            using (SqlConnection connection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\StayScapeDB.mdf;Integrated Security=True"))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userId", userId);

                    connection.Open();
                    object queryResult = command.ExecuteScalar();
                    if (queryResult != null)
                    {
                        result = (byte[])queryResult;
                    }
                }
            }

            return result;
        }

        protected void btnSignout_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut(); // Sign the user out
            Response.Redirect("Login.aspx"); // Redirect to the login page
        }

        public string ProfilePictureUrl
        {
            get { return imgProfilePicture.ImageUrl; }
            set { imgProfilePicture.ImageUrl = value; }
        }

    }
}