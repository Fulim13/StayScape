using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class OrderHistory : System.Web.UI.Page
    {

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
                ViewState["ReservationFilter"] = "All";
                BindReservationHistory();
            }
        }

        protected void FilterStatus_Click(object sender, EventArgs e)
        {
            Button clickedButton = (Button)sender;

            // Enable all buttons
            btnFilterAll.Enabled = true;
            btnFilterPaid.Enabled = true;
            btnFilterPending.Enabled = true;
            btnFilterFailed.Enabled = true;
            btnFilterCancelled.Enabled = true;

            // Remove 'selected' class from all buttons
            btnFilterAll.CssClass = btnFilterAll.CssClass.Replace("selected", "").Trim();
            btnFilterPaid.CssClass = btnFilterPaid.CssClass.Replace("selected", "").Trim();
            btnFilterPending.CssClass = btnFilterPending.CssClass.Replace("selected", "").Trim();
            btnFilterFailed.CssClass = btnFilterFailed.CssClass.Replace("selected", "").Trim();
            btnFilterCancelled.CssClass = btnFilterCancelled.CssClass.Replace("selected", "").Trim();

            clickedButton.CssClass += " selected";

            ViewState["ReservationFilter"] = "All"; // Set the filter to "All"
            if (clickedButton.ID == "btnFilterAll")
            {
                ViewState["ReservationFilter"] = "All";
            }
            else if (clickedButton.ID == "btnFilterPaid")
            {
                ViewState["ReservationFilter"] = "Paid";
            }
            else if (clickedButton.ID == "btnFilterPending")
            {
                ViewState["ReservationFilter"] = "Pending";
            }
            else if (clickedButton.ID == "btnFilterFailed")
            {
                ViewState["ReservationFilter"] = "Failed";
            }
            else if (clickedButton.ID == "btnFilterCancelled")
            {
                ViewState["ReservationFilter"] = "Cancelled";
            }

            BindReservationHistory(); // Re-bind the data
        }

        private void BindReservationHistory()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    r.reservationID AS ReservationID,
                    r.checkInDate AS CheckInDate,
                    r.checkOutDate AS CheckOutDate,
                    r.createdAt AS DatePlaced,
                    r.reservationStatus AS Status,
                    r.reservationTotal AS TotalAmount,
                    p.propertyName AS PropertyName,
                    p.propertyAddress AS PropertyAddress,
                    (SELECT TOP 1 propertyPicture FROM PropertyImage WHERE propertyID = p.propertyID) AS PropertyImage,
                    c.refundAmount AS RefundAmount
                FROM 
                    Reservation r
                LEFT JOIN 
                    Cancellation c ON r.reservationID = c.reservationID
                INNER JOIN 
                    Property p 
                ON 
                    r.propertyID = p.propertyID
                WHERE 
                    r.custID = @custID";

                // Modify the query based on the selected filter
                string reservationFilter = ViewState["ReservationFilter"]?.ToString();
                if (!string.IsNullOrEmpty(reservationFilter) && reservationFilter != "All")
                {
                    query += " AND r.reservationStatus = @status"; // Apply the status filter
                }

                query += " ORDER BY r.createdAt DESC"; // Order by date placed

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@custID", 1); // Replace with the actual customer ID

                if (reservationFilter != "All") // Add parameter for filtering by status
                {
                    cmd.Parameters.AddWithValue("@status", reservationFilter);
                }

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dataTable = new DataTable();
                dataTable.Load(reader); // Convert the SqlDataReader into a DataTable

                ReservationListView.DataSource = dataTable; // Now using a DataTable as the data source
                ReservationListView.DataBind();
            }
        }

        protected void ReservationListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if(e.Item.ItemType == ListViewItemType.DataItem)
    {
                var dataItem = (DataRowView)((ListViewDataItem)e.Item).DataItem; // Proper access
                var imgProperty = (Image)e.Item.FindControl("imgProperty");

                if (dataItem["PropertyImage"] != DBNull.Value)
                {
                    byte[] imageData = (byte[])dataItem["PropertyImage"];
                    string base64String = Convert.ToBase64String(imageData);
                    imgProperty.ImageUrl = "data:image/jpeg;base64," + base64String;
                }
                else
                {
                    imgProperty.ImageUrl = "/Images/testing.jpg"; // Default image if not found
                }


                // Get the reservation ID
                string reservationID = dataItem["ReservationID"].ToString();

                // Check if a review exists for this reservation
                bool hasReview = CheckIfReviewExists(reservationID);

                // Get reservation status and check-out date
                string reservationStatus = dataItem["Status"].ToString();

                // Get the refund label
                var lblRefundAmount = (Label)e.Item.FindControl("lblRefundAmount");

                // Show refund amount only if the reservation is cancelled
                if (reservationStatus.Equals("Cancelled", StringComparison.OrdinalIgnoreCase))
                {
                    decimal refundAmount = 0;
                    if (dataItem["RefundAmount"] != DBNull.Value)
                    {
                        refundAmount = Convert.ToDecimal(dataItem["RefundAmount"]);
                    }

                    lblRefundAmount.Text = $"Refund: RM {refundAmount:F2}";
                    lblRefundAmount.Visible = true;
                }
                else
                {
                    lblRefundAmount.Visible = false; // Hide if not cancelled
                }

                DateTime checkOutDate = Convert.ToDateTime(dataItem["CheckOutDate"]);

                // Get the "Add Review" button and "View Review" button
                Button addReviewButton = (Button)e.Item.FindControl("btnAddReview");
                Button viewReviewButton = (Button)e.Item.FindControl("btnViewReview");

                if (hasReview)
                {
                    // If a review exists, hide the "Add Review" button
                    addReviewButton.Visible = false;
                    viewReviewButton.Visible = true; // Show the "View Review" button
                }
                else
                {
                    // Check if the reservation is paid and the check-out date has passed
                    bool isPaid = reservationStatus.Equals("Paid", StringComparison.OrdinalIgnoreCase);
                    bool isCheckOutPast = DateTime.Now > checkOutDate;

                    if (isPaid && isCheckOutPast)
                    {
                        // If reservation is paid and check-out date is in the past, allow adding review
                        addReviewButton.Visible = true;
                        viewReviewButton.Visible = false; // Hide the "View Review" button since there's no review yet
                    }
                    else
                    {
                        // If no review and conditions are not met, hide the "Add Review" button
                        addReviewButton.Visible = true;
                        addReviewButton.CssClass = "text-gray-500";
                        addReviewButton.Enabled = false;
                        viewReviewButton.Visible = false; // Hide both buttons if no review and not eligible to add
                    }
                }

                DateTime checkInDate = Convert.ToDateTime(dataItem["CheckInDate"]);
                DateTime DatePlaced = Convert.ToDateTime(dataItem["DatePlaced"]);

                // Check if the cancel button should be displayed
                Button cancelReservationButton = (Button)e.Item.FindControl("btnCancelReservation");

                bool isWithin24HoursOfBooking = (DateTime.Now - DatePlaced).TotalHours < 24;
                if (reservationStatus == "Paid" && (DateTime.Now < checkInDate || isWithin24HoursOfBooking))
                {
                    cancelReservationButton.CssClass = "text-indigo-600 hover:text-indigo-500 cursor-pointer"; // Default color
                    cancelReservationButton.Enabled = true; // Ensure it's clickable
                }
                else
                {
                    cancelReservationButton.CssClass = "text-gray-500"; // Gray out the button
                    cancelReservationButton.Enabled = false; // Disable the button
                }
            }
        }

        private bool CheckIfReviewExists(string reservationID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM Review WHERE reservationID = @reservationID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@reservationID", reservationID);

                conn.Open();
                int reviewCount = (int)cmd.ExecuteScalar(); // Check if a review exists

                return reviewCount > 0;  // Return true if a review exists
            }
        }


        protected void btnAddReview_Click(object sender, EventArgs e)
        {
            // Get the ListView item containing the clicked button
            var button = (Button)sender;
            var listViewItem = (ListViewItem)button.NamingContainer;

            // Get the reservation ID from the existing Label control
            var lblOrderNum = (Label)listViewItem.FindControl("lblOrderNum");
            Session["reservationID"] = lblOrderNum.Text;

            // Redirect to the review form with the reservation ID as a query parameter
            Response.Redirect("ReviewForm.aspx");
        }

        protected void btnViewReview_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            var listViewItem = (ListViewItem)button.NamingContainer;

            // Get the reservation ID
            var lblOrderNum = (Label)listViewItem.FindControl("lblOrderNum");
            string reservationID = lblOrderNum.Text;

            // Get the review details based on reservationID
            var review = GetReviewByReservationID(reservationID);

            string starRating = StarRatingHelper.GetStarRating(review.rating); // Assuming review.rating is a decimal
            // Display the rating as integer and add "/5"
            litStarRating.Text = starRating;
            lblCreatedAt.Text = review.reviewDate.ToString("MMMM dd, yyyy hh:mm tt");

            txtReviewDesc.Text = review.reviewDesc ?? "No review found";
            ViewState["reviewID"] = review.reviewID;
            // Open the modal
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openReviewModal();", true);
        }

        protected void btnSubmitEditReview_Click(object sender, EventArgs e)
        {
            // Retrieve the review ID from ViewState
            string reviewID = ViewState["reviewID"]?.ToString();

            if (string.IsNullOrEmpty(reviewID))
            {
                // Handle the error if review ID is missing
                return;
            }

            string updatedReviewDesc = txtReviewDesc.Text; // Get the edited review description

            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlCommand = @"
                    UPDATE Review 
                    SET reviewDesc = @reviewDesc 
                    WHERE reviewID = @reviewID";

                SqlCommand cmd = new SqlCommand(sqlCommand, conn);
                cmd.Parameters.AddWithValue("@reviewDesc", updatedReviewDesc);
                cmd.Parameters.AddWithValue("@reviewID", reviewID);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // After submitting, close the modal and possibly update the page to reflect changes
            ScriptManager.RegisterStartupScript(this, GetType(), "closeReviewModal", "closeReviewModal();", true);
        }

        protected void btnCancelReservation_Click(object sender, EventArgs e)
        {
            // Get the ListView item containing the clicked button
            var button = (Button)sender;
            var listViewItem = (ListViewItem)button.NamingContainer;

            // Get the reservation ID from the existing Label control
            var lblOrderNum = (Label)listViewItem.FindControl("lblOrderNum");

            Session["reservationID"] = lblOrderNum.Text;
            // Redirect to the form with the reservation ID as a query parameter
            Response.Redirect("CancelReservation.aspx");
        }

        private (string reviewID, string reviewDesc, decimal rating, DateTime reviewDate) GetReviewByReservationID(string reservationID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT reviewDesc, rating , reviewID, createdAt FROM Review WHERE reservationID = @reservationID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@reservationID", reservationID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string reviewID = reader["reviewID"].ToString();
                    string reviewDesc = reader["reviewDesc"].ToString();
                    decimal rating = Convert.ToDecimal(reader["rating"]);
                    DateTime reviewDate = reader["createdAt"] != DBNull.Value
                    ? Convert.ToDateTime(reader["createdAt"])
                    : DateTime.MinValue; // Use MinValue if 'createdAt' is null

                    return (reviewID, reviewDesc, rating, reviewDate); // Return a tuple with review description and rating
                }

                return (null, null, 0, DateTime.MinValue); // Default value if no review is found
            }
        }
        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "closeReviewModal", "closeReviewModal();", true);
        }

    }
}