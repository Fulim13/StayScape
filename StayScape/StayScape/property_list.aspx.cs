using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace StayScape.PPT
{
    public partial class property_list : System.Web.UI.Page
    {
        public List<PropertyModel> Properties { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            Properties = GetPropertiesFromDatabase();
        }
        private List<PropertyModel> GetPropertiesFromDatabase()
        {
            List<PropertyModel> properties = new List<PropertyModel>();

            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = "SELECT propertyID, propertyName, propertyPrice, propertyDesc, createdAt, lastUpdate FROM Property";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        PropertyModel property = new PropertyModel
                        {
                            PropertyID = reader.GetInt32(0),
                            PropertyName = reader["propertyName"].ToString(),
                            PropertyPrice = Convert.ToDecimal(reader["propertyPrice"]),
                            PropertyDesc = reader["propertyDesc"].ToString(),
                            CreatedAt = Convert.ToDateTime(reader["createdAt"]),
                            LastUpdate = Convert.ToDateTime(reader["lastUpdate"]),
                            TotalBedroom = reader.GetInt32(0),
                            TotalBathroom = reader.GetInt32(0),
                        };
                        properties.Add(property);
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {

                }
            }
            return properties;
        }
    }

    public class PropertyModel
    {
        public int PropertyID { get; set; }
        public string PropertyName { get; set; }
        public decimal PropertyPrice { get; set; }
        public string PropertyDesc { get; set; }
        public string PropertyAddress { get; set; }
        public int TotalBedroom { get; set; }
        public int TotalBathroom { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime LastUpdate { get; set; }

    }
}