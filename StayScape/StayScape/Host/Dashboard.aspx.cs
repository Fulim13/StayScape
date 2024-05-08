using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace StayScape
{
    public partial class Dashboard : System.Web.UI.Page
    {


        string baseQuery;
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            if (IsPostBack)
            {
                try
                {
                    if (Session["hostID"] != null)
                    {
                        string hostID = Session["hostID"].ToString();
                        string baseQuery = "SELECT r.reservationID, r.reservationTotal, r.checkInDate, r.checkOutDate, r.reservationStatus, c.customerName " +
                                           "FROM Reservation r " +
                                           "JOIN Property p ON r.propertyID = p.propertyID " +
                                           "JOIN Host h ON p.hostID = h.hostID " +
                                           "JOIN Customer c ON r.custID = c.custID " +
                                           "WHERE h.hostID = @hostID";

                        List<string> conditions = new List<string>();
                        List<string> parameters = new List<string>();

                        if (!string.IsNullOrEmpty(txtSearch.Text))
                        {
                            conditions.Add("r.reservationID LIKE @reservationID");
                            parameters.Add("%" + txtSearch.Text + "%");
                        }

                        if (ddlIsExpired.SelectedIndex != 0)
                        {
                            if (ddlIsExpired.SelectedValue == "paid")
                            {
                                conditions.Add("r.reservationStatus = 'Paid'");
                            }
                            else if (ddlIsExpired.SelectedValue == "failed")
                            {
                                conditions.Add("r.reservationStatus = 'Failed'");
                            }
                            else if (ddlIsExpired.SelectedValue == "cancelled")
                            {
                                conditions.Add("r.reservationStatus = 'Cancelled'");
                            }
                        }

                        if (conditions.Count > 0)
                        {
                            baseQuery += " AND " + string.Join(" AND ", conditions);
                        }

                        baseQuery += " ORDER BY r.createdAt DESC";

                        SqlDataSource1.SelectCommand = baseQuery;
                        SqlDataSource1.SelectParameters.Clear();
                        SqlDataSource1.SelectParameters.Add("hostID", hostID); // Adding hostID as parameter

                        if (!string.IsNullOrEmpty(txtSearch.Text))
                        {
                            SqlDataSource1.SelectParameters.Add("reservationID", DbType.String, parameters[0]);
                        }

                        ListView1.DataBind();
                    }
                    else
                    {
                        // Handle the case where hostID session variable is null
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message + "\n" + baseQuery + "\n" + SqlDataSource1.SelectCommand);
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            //string hostID = Session["hostID"].ToString();
            //Debug.WriteLine(Session["hostID"]);
            //var a = Session["hostID"];
            //Create host session
            //Session["hostID"] = 1;
            FetchData();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlIsExpired_SelectedIndexChanged(object sender, EventArgs e)
        {

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
                inlineStyles += "background-color: #feb2b2; color: #7f1d1d;";
            }
            else
            {
                inlineStyles += "background-color: #d1d5db; color: #4b5563;";
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
            decimal avgReservation = 0;
            // Fetch Average Reservation Made
            if (totalRevenue != "0" && totalReservation != "0")
            {
                avgReservation = Convert.ToDecimal(totalRevenue) / Convert.ToInt32(totalReservation);
                avgReservation = Math.Round(avgReservation, 2);
            }




            // Bind the fetched data to labels in the front end
            lblTotalRevenue.Text = "RM " + (totalRevenue.ToString() == "" ? "0" : totalRevenue.ToString());
            lblTotalReservation.Text = totalReservation.ToString();
            lblAvgReservation.Text = "RM " + avgReservation.ToString();
        }
    }
}