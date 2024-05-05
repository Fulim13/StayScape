using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class ReviewForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeViewState();

                string reservationID = Session["reservationID"]?.ToString();

                if (!string.IsNullOrEmpty(reservationID))
                {
                    LoadReservationDetails(reservationID);
                }
            }
            
        }

        protected void InitializeViewState()
        {
            // Initialize the button click states in ViewState (separate method for clarity)
            ViewState["Cleanliness"] = 0;
            ViewState["Service"] = 0;
            ViewState["Comfort"] = 0;
            ViewState["Condition"] = 0;
            ViewState["Amenities"] = 0;
            ViewState["Location"] = 0;
        }

        private void LoadReservationDetails(string reservationID)
        {
            DBManager db = new DBManager();
            db.createConnection();

            // SQL query to fetch property name, address, and picture
            string sqlCommand = @"
            SELECT 
                p.propertyName,
                p.propertyAddress,
                COALESCE(pi.propertyPicture, '') AS propertyPicture
            FROM 
                Reservation r
            INNER JOIN 
                Property p
            ON 
                r.propertyID = p.propertyID
            LEFT JOIN 
                PropertyImage pi
            ON 
                p.propertyID = pi.propertyID
            WHERE 
                r.reservationID = @reservationID";

            SqlParameter[] parameters =
            {
                new SqlParameter("@reservationID", reservationID)
            };

            SqlCommand command = db.ExecuteQuery(sqlCommand, parameters);
            SqlDataReader reader = command.ExecuteReader();

            if (reader.Read()) // We only expect one record
            {
                // Set the property name and address to appropriate controls
                lblPropertyName.Text = reader["propertyName"].ToString();
                lblPropertyAddress.Text = reader["propertyAddress"].ToString();

                // Handle the property picture
                if (reader["propertyPicture"] is byte[] imageData && imageData.Length > 0)
                {
                    string base64String = Convert.ToBase64String(imageData);
                    imgProperty.ImageUrl = "data:image/jpeg;base64," + base64String;
                }
                else
                {
                    // Handle case where no image is found
                    imgProperty.ImageUrl = "/Images/testing.jpg"; // Or any default image path
                }
            }

            db.closeConnection();
        }

        protected void RatingButton_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;

            if (button.CssClass.Contains("selected"))
            {
                button.CssClass = button.CssClass.Replace("selected", "").Trim();
            }
            else
            {
                button.CssClass += " selected";
            }

            // Toggle the state between 0 and 1
            switch (button.ID)
            {
                case "btnCleanliness":
                    ViewState["Cleanliness"] = (int)ViewState["Cleanliness"] == 0 ? 1 : 0;
                    break;

                case "btnService":
                    ViewState["Service"] = (int)ViewState["Service"] == 0 ? 1 : 0;
                    break;

                case "btnComfort":
                    ViewState["Comfort"] = (int)ViewState["Comfort"] == 0 ? 1 : 0;
                    break;

                case "btnCondition":
                    ViewState["Condition"] = (int)ViewState["Condition"] == 0 ? 1 : 0;
                    break;

                case "btnAmenities":
                    ViewState["Amenities"] = (int)ViewState["Amenities"] == 0 ? 1 : 0;
                    break;

                case "btnLocation":
                    ViewState["Location"] = (int)ViewState["Location"] == 0 ? 1 : 0;
                    break;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string newReviewID = GenerateNewReviewID();

                string reservationID = Session["reservationID"]?.ToString();
                string reviewDesc = reviewTxtbx.Text;
                decimal rating = decimal.Parse(RadioButtonList1.SelectedValue);
                string custID = GetCurrentCustomerID();
                // Get the current state from ViewState (0 or 1 for each button)
                int cleanlinessRating = (int)ViewState["Cleanliness"];
                int serviceRating = (int)ViewState["Service"];
                int comfortRating = (int)ViewState["Comfort"];
                int conditionRating = (int)ViewState["Condition"];
                int amenitiesRating = (int)ViewState["Amenities"];
                int locationRating = (int)ViewState["Location"];

                string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {

                    string insertQuery = @"
                INSERT INTO Review (
                    reviewID,
                    reviewDesc, 
                    rating,
                    cleanlinessRating, 
                    serviceRating, 
                    comfortRating, 
                    conditionRating, 
                    amenitiesRating, 
                    locationRating, 
                    createdAt,
                    custID,
                    reservationID
                ) 
                VALUES (
                    @reviewID,
                    @reviewDesc, 
                    @overallRating,
                    @cleanlinessRating,
                    @serviceRating,
                    @comfortRating,
                    @conditionRating,
                    @amenitiesRating,
                    @locationRating,
                    @createdAt,
                    @custID, 
                    @reservationID
                )";

                    SqlCommand cmd = new SqlCommand(insertQuery, conn);
                    cmd.Parameters.AddWithValue("@reviewID", newReviewID);
                    cmd.Parameters.AddWithValue("@reviewDesc", reviewDesc);
                    cmd.Parameters.AddWithValue("@overallRating", rating);
                    cmd.Parameters.AddWithValue("@cleanlinessRating", cleanlinessRating);
                    cmd.Parameters.AddWithValue("@serviceRating", serviceRating);
                    cmd.Parameters.AddWithValue("@comfortRating", comfortRating);
                    cmd.Parameters.AddWithValue("@conditionRating", conditionRating);
                    cmd.Parameters.AddWithValue("@amenitiesRating", amenitiesRating);
                    cmd.Parameters.AddWithValue("@locationRating", locationRating);
                    cmd.Parameters.AddWithValue("@createdAt", DateTime.Now);
                    cmd.Parameters.AddWithValue("@custID", custID);
                    cmd.Parameters.AddWithValue("@reservationID", reservationID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                thanksModal.CssClass = thanksModal.CssClass.Replace("hidden", "");
            }
            catch (Exception ex)
            {
                // Log the error (adjust this to your logging framework or error handling strategy)
                Console.WriteLine($"Error during review submission: {ex.Message}");
            }
        }

        private string GenerateNewReviewID()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Query to get the last reviewID
                string query = "SELECT TOP 1 reviewID FROM Review ORDER BY reviewID DESC";

                SqlCommand command = new SqlCommand(query, conn);

                conn.Open();
                object result = command.ExecuteScalar(); // Get the last reviewID

                string lastReviewID = result?.ToString(); // Handle if it's null
                string newReviewID;

                if (string.IsNullOrEmpty(lastReviewID))
                {
                    newReviewID = "RV0001"; // Start with this if there's no existing record
                }
                else
                {
                    int lastNumber = int.Parse(lastReviewID.Substring(2)); // Extract the number part
                    int nextNumber = lastNumber + 1;

                    newReviewID = $"RV{nextNumber:D4}"; // Format with leading zeros
                }

                return newReviewID;
            }
        }

        // TODO: Change to session
        private string GetCurrentCustomerID()
        {
            // Placeholder for actual host ID retrieval logic (from session, user context, etc.)
            return "1"; // Default customer ID
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/OrderHistory.aspx");
        }

        protected void ModalCloseButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/OrderHistory.aspx");
        }
    }
}