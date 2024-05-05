using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

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
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = @"
                SELECT P.propertyName, P.propertyPrice, P.propertyDesc, P.propertyAddress, P.propertyAddress_City, P.propertyAddress_State, P.totalBedroom, P.totalBathroom, P.createdAt, P.lastUpdate,
                PI.propertyPicture
                FROM Property P
                LEFT JOIN PropertyImage PI ON P.propertyID = PI.propertyID
                WHERE P.propertyID = @propertyID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@propertyID", propertyID);

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        if (property == null)
                        {
                            property = new PropertyModel
                            {
                                PropertyID = propertyID,
                                PropertyName = reader["propertyName"].ToString(),
                                PropertyPrice = Convert.ToDecimal(reader["propertyPrice"]),
                                PropertyDesc = reader["propertyDesc"].ToString(),
                                PropertyAddress = reader["propertyAddress"].ToString(),
                                PropertyAddress_City = reader["propertyAddress_City"].ToString(),
                                PropertyAddress_State = reader["propertyAddress_State"].ToString(),
                                TotalBedroom = Convert.ToInt32(reader["totalBedroom"]),
                                TotalBathroom = Convert.ToInt32(reader["totalBathroom"]),
                                CreatedAt = Convert.ToDateTime(reader["createdAt"]),
                                LastUpdate = Convert.ToDateTime(reader["lastUpdate"]),
                                PropertyImages = new List<byte[]>()
                            };
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
                    //handle execption
                }
            }

            return property;
        }


        protected void btnPlace_Click(object sender, EventArgs e)
        {
            //for checkout this date
            var checkInDate = Request.Form["checkInDate"];
            var checkOutDate = Request.Form["checkOutDate"];
            // Store the propertyID in the session
            Session["propertyID"] = Request.QueryString["propertyID"];
            Session["CheckIn"] = DateTime.Now;
            Session["CheckOut"] = DateTime.Now.AddDays(1);

            Response.Redirect("Checkout.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("property_list.aspx");
        }
    }

}