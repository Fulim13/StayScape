using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace StayScape
{
    public partial class property_host_insert : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UploadProperty(object sender, EventArgs e)
        {
            string propertyName = txtPropertyName.Text;
            decimal propertyPrice = decimal.Parse(txtPropertyPrice.Text);
            string propertyDesc = txtPropertyDesc.Text;
            string propertyAddress = txtPropertyAddress.Text;
            string propertyAddress_city = txtCity.Text;
            string propertyAddress_state = txtState.Text;
            int totalBedrooms = int.Parse(txtTotalBedrooms.Text);
            int totalBathrooms = int.Parse(txtTotalBathrooms.Text);

            // Save property details to the database
            int propertyID;
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Property (propertyName, propertyPrice, propertyDesc, propertyAddress, propertyAddress_City, propertyAddress_State, totalBedroom, totalBathroom, createdAt, lastUpdate) VALUES (@propertyName, @propertyPrice, @propertyDesc, @propertyAddress, @propertyAddress_city, @propertyAddress_state, @totalBedroom, @totalBathroom, GETDATE(), GETDATE()); SELECT SCOPE_IDENTITY();", conn);
                cmd.Parameters.AddWithValue("@propertyName", propertyName);
                cmd.Parameters.AddWithValue("@propertyPrice", propertyPrice);
                cmd.Parameters.AddWithValue("@propertyDesc", propertyDesc);
                cmd.Parameters.AddWithValue("@propertyAddress", propertyAddress);
                cmd.Parameters.AddWithValue("@propertyAddress_city", propertyAddress_city);
                cmd.Parameters.AddWithValue("@propertyAddress_state", propertyAddress_state);
                cmd.Parameters.AddWithValue("@totalBedroom", totalBedrooms);
                cmd.Parameters.AddWithValue("@totalBathroom", totalBathrooms);
                propertyID = Convert.ToInt32(cmd.ExecuteScalar());
            }

            // Save property image to the database
            if (fuPropertyImage.HasFiles)
            {
                foreach (HttpPostedFile postedFile in fuPropertyImage.PostedFiles)
                {
                    using (Stream fs = postedFile.InputStream)
                    {
                        byte[] buffer = new byte[fs.Length];
                        fs.Read(buffer, 0, (int)fs.Length);
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();
                            SqlCommand cmd = new SqlCommand("INSERT INTO PropertyImage (propertyPicture, propertyID) VALUES (@propertyPicture, @propertyID)", conn);
                            cmd.Parameters.AddWithValue("@propertyPicture", buffer);
                            cmd.Parameters.AddWithValue("@propertyID", propertyID);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }

            try
            {
                // Insert property logic here

                // If insert is successful
                lblSuccessMessage.Visible = true;
                lblSuccessMessage.Text = "Property added successfully.";

            }
            catch (Exception ex)
            {
                // Handle error situation
                lblSuccessMessage.Visible = true;
                lblSuccessMessage.ForeColor = System.Drawing.Color.Red; // Change color to red on error
                lblSuccessMessage.Text = "Error adding property: " + ex.Message;
            }

        }

    }
}