using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class Review : System.Web.UI.Page
    {
        private string connectionString;

        // Field to hold the star rating filter
        private int selectedStarRating = 0;

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
            // Initialize connection string at the beginning
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            }

            if (!IsPostBack)
            {
                UpdateRatingButtonCounts();
                BindListView(); // Show all reviews by default on initial page load
            }
        }

        protected void UpdateRatingButtonCounts()
        {
            // SQL query to get the count of reviews for each rating (1-5)
            string query = @"
            SELECT r.rating, COUNT(*) AS RatingCount
            FROM Review r
            INNER JOIN Reservation rs ON r.reservationID = rs.reservationID
            INNER JOIN Property p ON rs.propertyID = p.propertyID
            WHERE p.hostID = @hostID
            GROUP BY r.rating
            ORDER BY r.rating DESC"; // DESC to get 5 to 1

            // Dictionary to store the counts of each rating
            Dictionary<int, int> ratingCounts = new Dictionary<int, int>
            {
                { 1, 0 },
                { 2, 0 },
                { 3, 0 },
                { 4, 0 },
                { 5, 0 }
            };

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(query, conn);

                // Set hostID as a parameter
                cmd.Parameters.AddWithValue("@hostID", GetHostID()); // Function to get the host ID

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    if (!reader.IsDBNull(0))
                    {
                        // Retrieve as decimal, then convert/round to integer
                        decimal decimalRating = reader.GetDecimal(0);

                        // Convert to integer by rounding (e.g., for star ratings)
                        int rating = Convert.ToInt32(Math.Round(decimalRating));

                        int count = reader.GetInt32(1); // Get count for the rating

                        ratingCounts[rating] = count; // Update the dictionary
                    }
                }
            }

            // Update button text with the retrieved counts
            btn5Star.Text = $"5 Star({ratingCounts[5]})";
            btn4Star.Text = $"4 Star({ratingCounts[4]})";
            btn3Star.Text = $"3 Star({ratingCounts[3]})";
            btn2Star.Text = $"2 Star({ratingCounts[2]})";
            btn1Star.Text = $"1 Star({ratingCounts[1]})";
        }

        // TODO: Change to session
        private int GetHostID()
        {
            // Placeholder for actual host ID retrieval logic (from session, user context, etc.)
            return 1; // Default host ID
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindListView(); // Re-bind data based on search criteria
        }

        private void BindListView()
        {
            // Create SQL query dynamically based on search criteria
            string query = @"
                SELECT 
                    r.reviewID, 
                    r.reviewDesc, 
                    r.rating, 
                    r.createdAt, 
                    c.customerName,
                    p.propertyName, 
                    p.propertyAddress,
                    rep.replyID,
                    rep.replyText,
                    rep.repliedAt,
                    rep.repliedBy
                FROM 
                    Review r
                INNER JOIN 
                    Reservation rs ON r.reservationID = rs.reservationID
                INNER JOIN 
                    Property p ON rs.propertyID = p.propertyID
                INNER JOIN 
                    Customer c ON r.custID = c.custID
                LEFT JOIN 
                    Reply rep ON r.reviewID = rep.reviewID 
                "; // Use LEFT JOIN to check for related replies

            // Start with a flag to indicate if a condition has been added
            bool hasCondition = false;

            // Utility function to escape single quotes to prevent SQL injection
            string EscapeSingleQuotes(string input)
            {
                return input.Replace("'", "''");
            }

            // Property name filter
            if (!string.IsNullOrEmpty(propertyNameTextBox.Text))
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += $" p.propertyName LIKE '%{EscapeSingleQuotes(propertyNameTextBox.Text)}%' ";
                hasCondition = true; // Update flag to indicate a condition has been added
            }

            // Customer name filter
            if (!string.IsNullOrEmpty(custNameTextBox.Text))
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += $" c.customerName LIKE '%{EscapeSingleQuotes(custNameTextBox.Text)}%' ";
                hasCondition = true; // Update flag
            }

            // Date filter
            if (!string.IsNullOrEmpty(txtDate.Text))
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += $" CAST(r.createdAt AS DATE) = '{txtDate.Text}'"; // Correct SQL date format
                hasCondition = true; // Update flag
            }

            // Star rating filter
            if (selectedStarRating > 0) // If it's greater than 0, apply the filter
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += $" r.rating = {selectedStarRating}"; // Filter by star rating
                hasCondition = true; // Update flag
            }

            // Reply-based filter
            string selectedFilter = FilterRadioButtonList.SelectedValue;

            if (selectedFilter == "to-reply")
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += " rep.replyID IS NULL"; // Reviews without a reply
            }
            else if (selectedFilter == "replied")
            {
                query += hasCondition ? " AND" : " WHERE"; // Correct use of WHERE/AND
                query += " rep.replyID IS NOT NULL"; // Reviews with at least one reply
            }

            // Set the new query
            SqlDataSource1.SelectCommand = query;

            // Rebind data
            ListView1.DataBind();
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowReply")
            {
                // Access the TextBox and make it visible
                var replyTextBox = (TextBox)e.Item.FindControl("replyTextBox");
                replyTextBox.Visible = true;

                // Make the Submit and Cancel buttons visible
                var btnSubmitReply = (Button)e.Item.FindControl("btnSubmitReply");
                btnSubmitReply.Visible = true;

                var btnCancel = (Button)e.Item.FindControl("btnCancel");
                btnCancel.Visible = true;
            }
            else if (e.CommandName == "SubmitReply")
            {
                // Get the reply text and reviewID from the CommandArgument
                var replyTextBox = (TextBox)e.Item.FindControl("replyTextBox");
                var replyText = replyTextBox.Text;

                var reviewID = e.CommandArgument.ToString();

                // Logic to save the reply to the database
                SaveReplyToDatabase(reviewID, replyText);

                // Optional: show a success message (e.g., with a modal)
                ShowReplyModal();
            }
            else if (e.CommandName == "CancelReply")
            {
                var replyTextBox = (TextBox)e.Item.FindControl("replyTextBox");
                replyTextBox.Visible = false;

                var btnSubmitReply = (Button)e.Item.FindControl("btnSubmitReply");
                btnSubmitReply.Visible = false;

                var btnCancel = (Button)e.Item.FindControl("btnCancel");
                btnCancel.Visible = false;
            }
        }

        protected void SaveReplyToDatabase(string reviewID, string replyText)
        {
            // Initialize connectionString if not already initialized
            if (string.IsNullOrEmpty(connectionString))
            {
                connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            }

            // TODO: Replace session host id
            int hostID = 1;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check if there's an existing reply for this review
                string checkReplyQuery = "SELECT replyID FROM Reply WHERE reviewID = @reviewID";
                SqlCommand checkCmd = new SqlCommand(checkReplyQuery, conn);
                checkCmd.Parameters.AddWithValue("@reviewID", reviewID);

                object existingReplyID = checkCmd.ExecuteScalar(); // Retrieve existing reply ID if any

                if (existingReplyID != null)
                {
                    // If a reply exists, update it
                    string updateReplyQuery = @"
            UPDATE Reply 
            SET replyText = @replyText, repliedAt = @repliedAt 
            WHERE replyID = @replyID";

                    SqlCommand updateCmd = new SqlCommand(updateReplyQuery, conn);
                    updateCmd.Parameters.AddWithValue("@replyText", replyText);
                    updateCmd.Parameters.AddWithValue("@repliedAt", DateTime.Now);
                    updateCmd.Parameters.AddWithValue("@replyID", existingReplyID.ToString());

                    updateCmd.ExecuteNonQuery(); // Execute the update command
                }
                else
                {
                    // If no reply exists, insert a new reply
                    string insertReplyQuery = @"
            INSERT INTO Reply (replyID, replyText, repliedAt, repliedBy, reviewID)
            VALUES (@replyID, @replyText, @repliedAt, @repliedBy, @reviewID)";

                    // Generate new reply ID
                    string newReplyID = GenerateNewReplyID(conn);

                    SqlCommand insertCmd = new SqlCommand(insertReplyQuery, conn);
                    insertCmd.Parameters.AddWithValue("@replyID", newReplyID);
                    insertCmd.Parameters.AddWithValue("@replyText", replyText);
                    insertCmd.Parameters.AddWithValue("@repliedAt", DateTime.Now);
                    insertCmd.Parameters.AddWithValue("@repliedBy", hostID);
                    insertCmd.Parameters.AddWithValue("@reviewID", reviewID);

                    insertCmd.ExecuteNonQuery(); // Execute the insert command
                }
            }
            //// Generate the new reply ID
            //string newReplyID;
            //string query = "SELECT TOP 1 replyID FROM Reply ORDER BY replyID DESC";
            //using (SqlConnection conn = new SqlConnection(connectionString))
            //{
            //    conn.Open();

            //    SqlCommand cmd = new SqlCommand(query, conn);
            //    object result = cmd.ExecuteScalar(); // Get the last reply ID
            //    string lastReplyID = result?.ToString(); // Convert result to string or return null if no records

            //    // Generate the new reply ID based on the last one
            //    if (string.IsNullOrEmpty(lastReplyID))
            //    {
            //        newReplyID = "RP0001"; // If no records, start with RP0001
            //    }
            //    else
            //    {
            //        // Extract the numeric part, increment it, and format with leading zeros
            //        int lastNumber = int.Parse(lastReplyID.Substring(2)); // Get the number part
            //        int nextNumber = lastNumber + 1;

            //        newReplyID = $"RP{nextNumber:D4}"; // Generate the new reply ID with leading zeros
            //    }

            //    // SQL command to insert a new reply into the Reply table
            //    string insertQuery = @"
            //    INSERT INTO Reply (replyID, replyText, repliedAt, repliedBy, reviewID)
            //    VALUES (@replyID, @replyText, @repliedAt, @repliedBy, @reviewID)";

            //    // Insert the new reply into the database
            //    cmd = new SqlCommand(insertQuery, conn);
            //    cmd.Parameters.AddWithValue("@replyID", newReplyID);
            //    cmd.Parameters.AddWithValue("@replyText", replyText);
            //    cmd.Parameters.AddWithValue("@repliedAt", DateTime.Now);
            //    cmd.Parameters.AddWithValue("@repliedBy", hostID);
            //    cmd.Parameters.AddWithValue("@reviewID", reviewID);

            //    cmd.ExecuteNonQuery(); // Execute the insert command
            //}
        }

        private string GenerateNewReplyID(SqlConnection conn)
        {
            string newReplyID;
            string query = "SELECT TOP 1 replyID FROM Reply ORDER BY replyID DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            object result = cmd.ExecuteScalar(); // Get the last reply ID

            string lastReplyID = result?.ToString();

            if (string.IsNullOrEmpty(lastReplyID))
            {
                newReplyID = "RP0001"; // Start with this if there are no replies
            }
            else
            {
                // Extract the numeric part, increment it, and format with leading zeros
                int lastNumber = int.Parse(lastReplyID.Substring(2)); // Get the numeric part
                int nextNumber = lastNumber + 1; // Increment the number
                newReplyID = $"RP{nextNumber:D4}"; // Generate the new reply ID with leading zeros
            }

            return newReplyID;

        }

            protected void ShowReplyModal()
        {
            replyModal.CssClass = replyModal.CssClass.Replace("hidden", "").Trim(); // Make modal visible
        }

        protected void ModalCloseButton_Click(object sender, EventArgs e)
        {
            // Hide the modal by adding the "hidden" class
            if (!replyModal.CssClass.Contains("hidden"))
            {
                replyModal.CssClass += " hidden";
            }

            // Loop through all ListView items to find and reset relevant controls
            foreach (ListViewItem item in ListView1.Items)
            {
                var replyTextBox = (TextBox)item.FindControl("replyTextBox");
                if (replyTextBox != null)
                {
                    replyTextBox.Text = ""; // Clear the text box
                    replyTextBox.Visible = false; // Hide the text box
                }

                var btnSubmitReply = (Button)item.FindControl("btnSubmitReply");
                if (btnSubmitReply != null)
                {
                    btnSubmitReply.Visible = false; // Hide the submit button
                }

                var btnCancel = (Button)item.FindControl("btnCancel");
                if (btnCancel != null)
                {
                    btnCancel.Visible = false; // Hide the cancel button
                }
            }
        }

        //protected void btnReply_Click(object sender, EventArgs e)
        //{
        //    replyTextBox.Visible = true;
        //    btnSubmitReply.Visible = true;
        //    btnCancel.Visible = true;
        //}

        //protected void btnSubmitReply_Click(object sender, EventArgs e)
        //{
        //    replyModal.CssClass = replyModal.CssClass.Replace("hidden", "");
        //}

        //protected void btnCancel_Click(object sender, EventArgs e)
        //{
        //    replyTextBox.Visible = false;
        //    btnSubmitReply.Visible = false;
        //    btnCancel.Visible = false;
        //}

        //protected void ModalCloseButton_Click(object sender, EventArgs e)
        //{
        //    replyModal.CssClass += " hidden";
        //    replyTextBox.Visible = false;
        //    btnSubmitReply.Visible = false;
        //    btnCancel.Visible = false;
        //}

        protected void RadioButtonList_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindListView();
        }

        protected void RatingButton_Click(object sender, EventArgs e)
        {
            Button clickedButton = (Button)sender;

            // Enable all buttons
            btn5Star.Enabled = true;
            btn4Star.Enabled = true;
            btn3Star.Enabled = true;
            btn2Star.Enabled = true;
            btn1Star.Enabled = true;

            // Remove 'selected' class from all buttons
            btnAll.CssClass = btnAll.CssClass.Replace("selected", "").Trim();
            btn5Star.CssClass = btn5Star.CssClass.Replace("selected", "").Trim();
            btn4Star.CssClass = btn4Star.CssClass.Replace("selected", "").Trim();
            btn3Star.CssClass = btn3Star.CssClass.Replace("selected", "").Trim();
            btn2Star.CssClass = btn2Star.CssClass.Replace("selected", "").Trim();
            btn1Star.CssClass = btn1Star.CssClass.Replace("selected", "").Trim();

            clickedButton.CssClass += " selected";

            // Determine which star rating was selected
            int starRating = 0; // Default: no star rating filter

            if (clickedButton.ID == "btnAll")
            {
                starRating = 0; // No specific star filter
            }
            else if (clickedButton.ID == "btn5Star")
            {
                starRating = 5; // Filter for 5-star reviews
            }
            else if (clickedButton.ID == "btn4Star")
            {
                starRating = 4; // Filter for 4-star reviews
            }
            else if (clickedButton.ID == "btn3Star")
            {
                starRating = 3; // Filter for 3-star reviews
            }
            else if (clickedButton.ID == "btn2Star")
            {
                starRating = 2; // Filter for 2-star reviews
            }
            else if (clickedButton.ID == "btn1Star")
            {
                starRating = 1; // Filter for 1-star reviews
            }

            selectedStarRating = starRating; // Update the selected star rating
            BindListView();
        }

    }
}