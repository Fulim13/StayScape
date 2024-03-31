using System;
using System.Configuration;
using System.Data.SqlClient;

namespace StayScape.PPT
{
    public partial class property_details : System.Web.UI.Page
    {
        public PropertyModel Property { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["propertyID"] != null)
                {
                    int propertyID = Convert.ToInt32(Request.QueryString["propertyID"]);
                    Property = GetPropertyFromDatabase(propertyID);
                }
            }
        }

        private PropertyModel GetPropertyFromDatabase(int propertyID)
        {
            PropertyModel property = null;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT propertyName, propertyPrice, propertyDesc, propertyAddress, totalBedroom, totalBathroom, createdAt, lastUpdate FROM Property WHERE propertyID = @propertyID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@propertyID", propertyID);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        property = new PropertyModel
                        {
                            PropertyName = reader["propertyName"].ToString(),
                            PropertyPrice = Convert.ToDecimal(reader["propertyPrice"]),
                            PropertyDesc = reader["propertyDesc"].ToString(),
                            PropertyAddress = reader["propertyAddress"].ToString(),
                            TotalBedroom = Convert.ToInt32(reader["totalBedroom"]),
                            TotalBathroom = Convert.ToInt32(reader["totalBathroom"]),
                            CreatedAt = Convert.ToDateTime(reader["createdAt"]),
                            LastUpdate = Convert.ToDateTime(reader["lastUpdate"])
                        };
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                }
            }

            return property;
        }

        protected void btnPlace_Click(object sender, EventArgs e)
        {
            // Store the propertyID in the session
            Session["propertyID"] = 1;
            Session["CheckIn"] = DateTime.Now;
            Session["CheckOut"] = DateTime.Now.AddDays(1);

            Response.Redirect("Checkout.aspx");
        }
    }

}