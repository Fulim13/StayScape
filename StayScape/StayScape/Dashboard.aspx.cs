using System;
using System.Data.SqlClient;

namespace StayScape
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Create host session
            Session["hostID"] = 1;
            FetchData();
        }

        protected string GetStatusLabelCss(string status)
        {
            string inlineStyles = "display: inline-flex; border-radius: 9999px; padding: 0.5rem 1rem; font-size: 0.75rem; font-weight: 600; line-height: 1.5; ";
            if (status == "Paid")
            {
                inlineStyles += "background-color: #d1fae5; color: #065f46;";
            }
            else if (status == "Failed")
            {
                inlineStyles += "background-color: #d1d5db; color: #4b5563;";
            }
            else
            {
                inlineStyles += "background-color: #feb2b2; color: #7f1d1d;";
            }

            return inlineStyles;
        }

        private void FetchData()
        {
            DBManager db = new DBManager();
            db.createConnection();
            // Fetch Total Revenue
            string totalRevenueQuery = "SELECT SUM(reservationTotal) FROM Reservation r INNER JOIN Property p ON r.propertyID = p.propertyID WHERE p.hostID = @hostID AND r.reservationStatus = 'Paid'";
            SqlParameter[] parameters =
            {
                new SqlParameter("@hostID", Session["hostID"])
            };
            SqlCommand command = db.ExecuteQuery(totalRevenueQuery, parameters);
            string totalRevenue = command.ExecuteScalar().ToString();
            db.closeConnection();

            // Fetch Total Reservation
            db.createConnection();
            string totalReservationQuery = "SELECT COUNT(*) FROM Reservation r INNER JOIN Property p ON r.propertyID = p.propertyID WHERE p.hostID = @hostID AND r.reservationStatus = 'Paid'";
            SqlParameter[] parameters2 =
            {
                new SqlParameter("@hostID", Session["hostID"])
            };
            SqlCommand command2 = db.ExecuteQuery(totalReservationQuery, parameters2);
            string totalReservation = command2.ExecuteScalar().ToString();
            db.closeConnection();

            // Fetch Average Reservation Made
            decimal avgReservation = Convert.ToDecimal(totalRevenue) / Convert.ToInt32(totalReservation);

            // Bind the fetched data to labels in the front end
            lblTotalRevenue.Text = "RM " + totalRevenue.ToString();
            lblTotalReservation.Text = totalReservation.ToString();
            lblAvgReservation.Text = "RM " + avgReservation.ToString();
        }
    }
}