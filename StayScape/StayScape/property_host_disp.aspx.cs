using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace StayScape
{
    public partial class property_host_disp : Page
    {
        public List<PropertyModel> Properties { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProperties();
                PropertiesRepeater.DataSource = Properties;
                PropertiesRepeater.DataBind();
            }
        }

        private void LoadProperties()
        {
            Properties = new List<PropertyModel>();
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = @"
                 SELECT P.propertyID, P.propertyName, P.propertyPrice, P.propertyDesc, P.propertyAddress, 
                    P.propertyAddress_City, P.propertyAddress_State, P.totalBedroom, P.totalBathroom, 
                    P.createdAt, P.lastUpdate, P.isActive,
                    (SELECT TOP 1 PI.propertyPicture FROM PropertyImage PI WHERE PI.propertyID = P.propertyID) AS propertyPicture
                FROM Property P";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    var property = new PropertyModel
                    {
                        PropertyID = (int)reader["propertyID"],
                        PropertyName = reader["propertyName"].ToString(),
                        PropertyPrice = (decimal)reader["propertyPrice"],
                        PropertyDesc = reader["propertyDesc"].ToString(),
                        PropertyAddress = reader["propertyAddress"].ToString(),
                        PropertyAddress_City = reader["propertyAddress_City"].ToString(),
                        PropertyAddress_State = reader["propertyAddress_State"].ToString(),
                        TotalBedroom = (int)reader["totalBedroom"],
                        TotalBathroom = (int)reader["totalBathroom"],
                        CreatedAt = (DateTime)reader["createdAt"],
                        LastUpdate = (DateTime)reader["lastUpdate"],
                        IsActive = (bool)reader["isActive"],
                        PropertyImages = reader["propertyPicture"] is DBNull ? null : (byte[])reader["propertyPicture"]
                    };

                    if (!(reader["propertyPicture"] is DBNull))
                    {
                        property.PropertyImages = (byte[])reader["propertyPicture"];
                    }
                    else
                    {
                        property.PropertyImages = null; // Explicitly set to null if no image
                    }

                    Properties.Add(property);
                }
            }
        }
    }

    public class PropertyModel
    {
        public int PropertyID { get; set; }
        public string PropertyName { get; set; }
        public decimal PropertyPrice { get; set; }
        public string PropertyDesc { get; set; }
        public string PropertyAddress { get; set; }
        public string PropertyAddress_City { get; set; }
        public string PropertyAddress_State { get; set; }
        public int TotalBedroom { get; set; }
        public int TotalBathroom { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime LastUpdate { get; set; }
        public bool IsActive { get; set; }
        public byte[] PropertyImages { get; set; }
    }
}
