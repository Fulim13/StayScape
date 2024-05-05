using System;
using System.Data.SqlClient;

namespace StayScape
{
    public partial class PaymentSuccessful : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ////only first time page load
            //if (IsPostBack)
            //{
            //    return;
            //}

            // Get the Reservation ID from the session
            string reservationID = Session["reservationID"].ToString();

            // Get Property name from reservation ID
            DBManager db = new DBManager();
            db.createConnection();
            string sqlCommand = "SELECT Property.propertyName FROM Reservation INNER JOIN Property ON Reservation.propertyID = Property.propertyID WHERE reservationID = @reservationID";
            SqlParameter[] parameters =
            {
                new SqlParameter("@reservationID", reservationID)
            };
            SqlCommand command = db.ExecuteQuery(sqlCommand, parameters);
            string propertyName = command.ExecuteScalar().ToString();
            db.closeConnection();

            //Get the property Image from the session reservation ID
            db.createConnection();
            //sqlCommand = "SELECT propertyPicture FROM PropertyImage WHERE propertyID = @propertyID";
            sqlCommand = "SELECT propertyPicture FROM PropertyImage WHERE propertyID = (SELECT propertyID FROM Reservation WHERE reservationID = @reservationID)";
            SqlParameter[] parameters2 =
            {
                new SqlParameter("@reservationID", reservationID)
            };
            command = db.ExecuteQuery(sqlCommand, parameters2);
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                byte[] imageData = (byte[])reader["propertyPicture"];
                string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                imgProperty.ImageUrl = "data:image/jpeg;base64," + base64String;
            }
            else
            {
                // Handle case where no image is found
                imgProperty.ImageUrl = "/Images/testing.jpg"; // Or any default image path
            }

            //Get Reservation Details
            db.createConnection();
            sqlCommand = "SELECT reservationAmount, discountAmount, reservationTotal, checkInDate, checkOutDate FROM Reservation WHERE reservationID = @reservationID";
            SqlParameter[] parametersReservationDetails =
   {
                    new SqlParameter("@reservationID", reservationID)
                };
            command = db.ExecuteQuery(sqlCommand, parametersReservationDetails);
            reader = command.ExecuteReader();
            reader.Read();
            decimal reservationAmount = Convert.ToDecimal(reader["reservationAmount"]);
            decimal discountAmount = Convert.ToDecimal(reader["discountAmount"]);
            decimal totalAmount = Convert.ToDecimal(reader["reservationTotal"]);
            DateTime checkInDate = Convert.ToDateTime(reader["checkInDate"]);
            DateTime checkOutDate = Convert.ToDateTime(reader["checkOutDate"]);

            //Get Customer Name and Email from reservation ID
            db.createConnection();
            sqlCommand = "SELECT Customer.customerName, Customer.custEmail FROM Reservation INNER JOIN Customer ON Reservation.custID = Customer.custID WHERE reservationID = @reservationID";

            SqlParameter[] parametersCustomerDetails =
    {
        new SqlParameter("@reservationID", reservationID)
    };
            command = db.ExecuteQuery(sqlCommand, parametersCustomerDetails);
            reader = command.ExecuteReader();
            reader.Read();
            string customerName = reader["customerName"].ToString();
            string customerEmail = reader["custEmail"].ToString();
            db.closeConnection();

            //Get Payment Details from reservation ID
            db.createConnection();
            sqlCommand = "SELECT paymentMethod, paymentMethodDetail FROM Payment WHERE reservationID = @reservationID";
            SqlParameter[] parametersPaymentDetails =
{
        new SqlParameter("@reservationID", reservationID)
    };
            command = db.ExecuteQuery(sqlCommand, parametersPaymentDetails);
            reader = command.ExecuteReader();
            reader.Read();
            string paymentMethod = reader["paymentMethod"].ToString();
            string paymentMethodDetail = reader["paymentMethodDetail"].ToString();
            db.closeConnection();


            //Set the values to the labels
            lblOrderNum.Text = "Order Number: " + reservationID;
            lblProperty.Text = propertyName;
            lblDate.Text = checkInDate.ToString("dd MMMM yyyy") + " - " + checkOutDate.ToString("dd MMMM yyyy");
            lblCustName.Text = customerName;
            lblCustEmail.Text = customerEmail;
            lblPaymentMethod.Text = paymentMethod;
            lblPaymentDetails.Text = paymentMethodDetail;
            lblSubtotal.Text = "RM " + reservationAmount.ToString();
            lblPrice.Text = "RM " + totalAmount.ToString();
            lblDiscountPrice.Text = "RM " + discountAmount.ToString();
            lblTotal.Text = "RM " + totalAmount.ToString();

            //Clear the session beside user session
            //Session.Remove("reservationID");

        }

        protected void btnOrderHistory_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderHistory.aspx?propertyID=");
        }
    }
}