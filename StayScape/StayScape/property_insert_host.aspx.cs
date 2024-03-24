using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class property_insert_host : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void UploadProperty_Click(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;Initial Catalog=StayScapeDB;Integrated Security=True;";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = "INSERT INTO Property (propertyName, propertyPrice, propertyDesc, propertyAddress, totalBedroom, totalBathroom, createdAt, lastUpdate) " +
                                   "VALUES (@propertyName, @propertyPrice, @propertyDesc, @propertyAddress, @totalBedroom, @totalBathroom, @createdAt, @lastUpdate)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@propertyName", propertyName.Value);
                    command.Parameters.AddWithValue("@propertyPrice", Convert.ToDecimal(propertyPrice.Value));
                    command.Parameters.AddWithValue("@propertyDesc", propertyDescription.Value);
                    command.Parameters.AddWithValue("@propertyAddress", propertyAddress.Value);
                    command.Parameters.AddWithValue("@totalBedroom", Convert.ToInt32(totalBedrooms.Value));
                    command.Parameters.AddWithValue("@totalBathroom", Convert.ToInt32(totalBathrooms.Value));
                    command.Parameters.AddWithValue("@createdAt", DateTime.Now);
                    command.Parameters.AddWithValue("@lastUpdate", DateTime.Now);
                    command.ExecuteNonQuery();
                    lblMessage.Text = "Property uploaded successfully!";
                    ClearForm();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        private void ClearForm()
        {
            propertyName.Value = "";
            propertyPrice.Value = "";
            propertyDescription.Value = "";
            propertyAddress.Value = "";
            totalBedrooms.Value = "";
            totalBathrooms.Value = "";
        }
    }
}