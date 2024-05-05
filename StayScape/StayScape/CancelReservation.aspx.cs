using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class CancelReservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                string reservationID = Session["reservationID"]?.ToString();

                if (!string.IsNullOrEmpty(reservationID))
                {
                    // Store the reservation ID in session for later use
                    Session["reservationID"] = reservationID;

                    // Update the HyperLink to include the reservation ID in the NavigateUrl
                    navLink.NavigateUrl = "CancellationPolicy.aspx";

                    LoadReservationDetails(reservationID);
                }
            }
        }

        private void LoadReservationDetails(string reservationID)
        {
            DBManager db = new DBManager();
            db.createConnection();

            // SQL query to fetch property name, address, and picture
            string sqlCommand = @"
            SELECT 
                p.propertyName,
                r.checkInDate,
                r.checkOutDate,
                r.reservationTotal,
                r.createdAt
            FROM 
                Reservation r
            INNER JOIN 
                Property p
            ON 
                r.propertyID = p.propertyID
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
                lblPropertyName.Text = reader["propertyName"].ToString();
                lblCheckInOutDate.Text = Convert.ToDateTime(reader["checkInDate"]).ToString("yyyy-MM-dd") + " - " + Convert.ToDateTime(reader["checkOutDate"]).ToString("yyyy-MM-dd");
                //lblCheckOutDate.Text = "Check-out Date: " + Convert.ToDateTime(reader["checkOutDate"]).ToString("yyyy-MM-dd");
                lblReservationDate.Text = Convert.ToDateTime(reader["createdAt"]).ToString("yyyy-MM-dd");
                lblReservationTotal.Text = "RM " + Convert.ToDecimal(reader["reservationTotal"]).ToString("N2");
            }

            db.closeConnection();
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string reservationID = Request.QueryString["reservationID"] ?? Session["reservationID"]?.ToString();

            if (string.IsNullOrEmpty(reasonRbl.SelectedValue))
            {
                string strError = "Please select a cancellation reason!";
                lblError.Text = strError;
                // Re-load reservation details to prevent data loss after error
                if (!string.IsNullOrEmpty(reservationID))
                {
                    LoadReservationDetails(reservationID);
                }

                return;
            }

            string selectedReason = reasonRbl.SelectedValue;

            decimal reservationTotal = 0;
            DateTime checkInDate = DateTime.MinValue;

            // Fetch the reservation total and check-in date
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

            if (string.IsNullOrEmpty(reservationID))
            {
                // Handle error or redirect because reservation ID is missing
                throw new Exception("Reservation ID is missing.");
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlCommand = @"
                SELECT 
                    r.reservationTotal,
                    r.checkInDate
                FROM 
                    Reservation r
                WHERE 
                    r.reservationID = @reservationID";

                SqlCommand cmd = new SqlCommand(sqlCommand, conn);
                cmd.Parameters.AddWithValue("@reservationID", reservationID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    reservationTotal = Convert.ToDecimal(reader["reservationTotal"]);
                    checkInDate = Convert.ToDateTime(reader["checkInDate"]);
                }

                conn.Close();
            }

            decimal refundAmount = CalculateRefund(reservationTotal, checkInDate);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string sqlCommand = @"
                INSERT INTO Cancellation (reason, cancellationDate, refundAmount, reservationID)
                VALUES (@reason,@cancellationDate,@refundAmount, @reservationID);

                UPDATE Reservation
                SET 
                    reservationStatus = 'Cancelled'
                WHERE
                    reservationID = @reservationID";

                SqlCommand cmd = new SqlCommand(sqlCommand, conn);
                cmd.Parameters.AddWithValue("@reason", selectedReason);
                cmd.Parameters.AddWithValue("@cancellationDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@refundAmount", refundAmount);
                cmd.Parameters.AddWithValue("@reservationID", reservationID);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            //successCancelModal.CssClass = successCancelModal.CssClass.Replace("hidden", "");
            ShowSuccessModal(refundAmount);
        }

        private decimal CalculateRefund(decimal reservationTotal, DateTime checkInDate)
        {
            TimeSpan timeUntilCheckIn = checkInDate - DateTime.Now;

            if (timeUntilCheckIn.TotalDays >= 7)
            {
                return reservationTotal; // Full refund
            }
            else if (timeUntilCheckIn.TotalDays >= 3)
            {
                return reservationTotal * 0.5m; // 50% refund
            }
            else if (timeUntilCheckIn.TotalHours >= 48)
            {
                return reservationTotal * 0.25m; // 25% refund
            }
            else
            {
                return 0; // No refund
            }
        }
        private void ShowSuccessModal(decimal refundAmount)
        {
            var refundText = refundAmount > 0
                ? $"Your reservation was successfully cancelled. <br />The refund amount is RM {refundAmount:F2}."
                : "Your reservation was successfully cancelled. <br />No refund is applicable.";

            //var modalText = (Label)FindControl("lblSuccessCancelText");
            lblSuccessCancelText.Text = refundText;

            successCancelModal.CssClass = successCancelModal.CssClass.Replace("hidden", ""); // Show the modal
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