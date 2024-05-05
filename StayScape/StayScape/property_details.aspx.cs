using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;
using System.Web;

namespace StayScape.PPT
{
    public partial class property_details : System.Web.UI.Page
    {
        public PropertyModel Property { get; set; }
        public class StarRatingHelper
        {
            public static string GetStarRating(decimal rating)
            {
                int starCount = (int)Math.Round(rating);
                // SVG code for full star
                string fullStarSvg = "<svg class=\"w-6 h-6 text-yellow-300\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\"><path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\" /></svg>";

                // SVG code for empty star
                string emptyStarSvg = "<svg class=\"w-6 h-6 text-gray-300\" aria-hidden=\"true\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"currentColor\" viewBox=\"0 0 22 20\"><path d=\"M20.924 7.625a1.523 1.523 0 0 0-1.238-1.044l-5.051-.734-2.259-4.577a1.534 1.534 0 0 0-2.752 0L7.365 5.847l-5.051.734A1.535 1.535 0 0 0 1.463 9.2l3.656 3.563-.863 5.031a1.532 1.532 0 0 0 2.226 1.616L11 17.033l4.518 2.375a1.534 1.534 0 0 0 2.226-1.617l-.863-5.03L20.537 9.2a1.523 1.523 0 0 0 .387-1.575Z\" /></svg>";

                StringBuilder stars = new StringBuilder();

                // Append the correct number of full stars
                for (int i = 0; i < starCount; i++)
                {
                    stars.Append(fullStarSvg);
                }

                // Append the correct number of empty stars (out of 5)
                for (int i = starCount; i < 5; i++)
                {
                    stars.Append(emptyStarSvg);
                }

                return stars.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["propertyID"] != null)
                {
                    int propertyID = Convert.ToInt32(Request.QueryString["propertyID"]);
                    Property = GetPropertyFromDatabase(propertyID);
                    BindReviewSummary(propertyID);
                    BindReviewListView(propertyID);
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

        private void BindReviewListView(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            string query = @"
            SELECT 
                r.reviewID,
                r.reviewDesc,
                r.rating,
                r.cleanlinessRating,
                r.serviceRating,
                r.comfortRating,
                r.conditionRating,
                r.amenitiesRating,
                r.locationRating,
                r.createdAt AS ReviewDate,
                c.customerName,
                c.custProfilePic,
                rs.reservationID,
                p.propertyName,
                p.propertyAddress
            FROM 
                Review r
            INNER JOIN 
                Reservation rs ON r.reservationID = rs.reservationID
            INNER JOIN 
                Customer c ON r.custID = c.custID
            INNER JOIN 
                Property p ON rs.propertyID = p.propertyID
            WHERE 
                p.propertyID = @propertyID
            ORDER BY 
                r.createdAt DESC
            ";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@propertyID", propertyID);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                DataTable dataTable = new DataTable();
                dataTable.Load(reader); // Convert the SqlDataReader into a DataTable

                try
                {
                    ListViewReview.DataSource = dataTable;
                    ListViewReview.DataBind();
                }
                catch (Exception ex)
                {
                    // Handle exception
                }
            }
        }

        protected void ListViewReview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                // Get the data item
                var dataItem = (System.Data.DataRowView)e.Item.DataItem;

                // Get the image control
                var imgCustomer = (Image)e.Item.FindControl("imgCustomer");

                // Check if there's image data
                if (dataItem["custProfilePic"] != DBNull.Value)
                {
                    byte[] imageData = (byte[])dataItem["custProfilePic"];
                    string base64String = Convert.ToBase64String(imageData);
                    imgCustomer.ImageUrl = "data:image/jpeg;base64," + base64String;
                }
                else
                {
                    // Set a default image if no image data is available
                    imgCustomer.ImageUrl = "/Images/default-customer.jpg"; // Path to default image
                }
            }
        }

        private void BindReviewSummary(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT 
                COUNT(*) AS TotalReviews,
                AVG(rating) AS AverageRating,
                AVG(cleanlinessRating) AS AverageCleanliness,
                AVG(serviceRating) AS AverageService,
                AVG(comfortRating) AS AverageComfort,
                AVG(conditionRating) AS AverageCondition,
                AVG(amenitiesRating) AS AverageAmenities,
                AVG(locationRating) AS AverageLocation
            FROM 
                Review r
            INNER JOIN 
                Reservation rs ON r.reservationID = rs.reservationID
            WHERE 
                rs.propertyID = @propertyID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read() && reader["TotalReviews"] != DBNull.Value && Convert.ToInt32(reader["TotalReviews"]) > 0)
                {
                    int totalReviews = Convert.ToInt32(reader["TotalReviews"]);
                    decimal averageRating = reader["AverageRating"] != DBNull.Value
                    ? Convert.ToDecimal(reader["AverageRating"])
                    : 0;
                    //decimal averageCleanliness = Convert.ToDecimal(reader["AverageCleanliness"]);
                    //decimal averageService = Convert.ToDecimal(reader["AverageService"]);
                    //decimal averageComfort = Convert.ToDecimal(reader["AverageComfort"]);
                    //decimal averageCondition = Convert.ToDecimal(reader["AverageCondition"]);
                    //decimal averageAmenities = Convert.ToDecimal(reader["AverageAmenities"]);
                    //decimal averageLocation = Convert.ToDecimal(reader["AverageLocation"]);

                    lblTotalReviews.Text = $"Based on {totalReviews} reviews";
                    lblAverageRating.Text = $"{averageRating:F1}/5.0";

                    // Use the StarRatingHelper to generate the correct star rating
                    lblStars.Text = StarRatingHelper.GetStarRating(averageRating);

                    lblCleanliness.Text = reader["AverageCleanliness"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageCleanliness"]):F1}"
                    : "-";
                    lblService.Text = reader["AverageService"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageService"]):F1}"
                    : "-";
                    lblComfort.Text = reader["AverageComfort"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageComfort"]):F1}"
                    : "-";
                    lblCondition.Text = reader["AverageCondition"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageCondition"]):F1}"
                    : "-";
                    lblAmenities.Text = reader["AverageAmenities"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageAmenities"]):F1}"
                    : "-";
                    lblLocation.Text = reader["AverageLocation"] != DBNull.Value
                    ? $"{Convert.ToDecimal(reader["AverageLocation"]):F1}"
                    : "-";
                    //lblService.Text = $"{averageService:F1}";
                    //lblComfort.Text = $"{averageComfort:F1}";
                    //lblCondition.Text = $"{averageCondition:F1}";
                    //lblAmenities.Text = $"{averageAmenities:F1}";
                    //lblLocation.Text = $"{averageLocation:F1}";
                }
            }
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