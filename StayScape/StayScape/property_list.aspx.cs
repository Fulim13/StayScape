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
            Dictionary<int, PropertyModel> propertyDictionary = new Dictionary<int, PropertyModel>();

            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = @"
        SELECT P.propertyID, P.propertyName, P.propertyPrice, P.propertyDesc, P.createdAt, P.lastUpdate,
        P.totalBedroom, P.totalBathroom, P.propertyAddress_State, PI.propertyPicture
        FROM Property P
        LEFT JOIN PropertyImage PI ON P.propertyID = PI.propertyID
        WHERE P.isActive = 1";  // Added WHERE clause to only select active properties

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        int propertyID = reader.GetInt32(0);
                        if (!propertyDictionary.TryGetValue(propertyID, out PropertyModel property))
                        {
                            property = new PropertyModel
                            {
                                PropertyID = propertyID,
                                PropertyName = reader["propertyName"].ToString(),
                                PropertyPrice = Convert.ToDecimal(reader["propertyPrice"]),
                                PropertyDesc = reader["propertyDesc"].ToString(),
                                CreatedAt = Convert.ToDateTime(reader["createdAt"]),
                                LastUpdate = Convert.ToDateTime(reader["lastUpdate"]),
                                TotalBedroom = reader.GetInt32(6),
                                TotalBathroom = reader.GetInt32(7),
                                PropertyAddress_State = reader["propertyAddress_State"].ToString(),
                                PropertyImages = new List<byte[]>()
                            };
                            propertyDictionary.Add(propertyID, property);
                        }
                        if (!(reader["propertyPicture"] is DBNull))
                        {
                            property.PropertyImages.Add((byte[])reader["propertyPicture"]);
                        }
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Log or handle the exception
                    // Consider notifying the user or re-throwing the exception after logging
                }
            }
            return new List<PropertyModel>(propertyDictionary.Values);
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
        public List<byte[]> PropertyImages { get; set; } = new List<byte[]>(); // Store multiple images
    }

}