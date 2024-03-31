using System;
using System.Data;
using System.Data.SqlClient;

namespace StayScape
{
    public partial class PaymentProcessing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get Session Values
            int propertyID = Convert.ToInt32(Session["PropertyID"]);
            DateTime checkIn = Convert.ToDateTime(Session["CheckIn"]);
            DateTime checkOut = Convert.ToDateTime(Session["CheckOut"]);
            decimal reservationAmount = Convert.ToDecimal(Session["reservationAmount"]);
            decimal discountAmount = Convert.ToDecimal(Session["discountAmount"]);
            decimal totalAmount = reservationAmount - discountAmount;
            if (Session["reservationID"] == null)
            {
                string reservationID = Guid.NewGuid().ToString();
                Session["reservationID"] = reservationID;


            }

            //Check the reservation is on reservation table
            //If got do proceed
            //else insert into reservation table
            DBManager db = new DBManager();
            db.createConnection();
            string sqlCommand = "SELECT COUNT(*) FROM Reservation WHERE reservationID = @reservationID";
            SqlParameter parameter = new SqlParameter("@reservationID", Convert.ToString(Session["reservationID"]));
            SqlCommand command = db.ExecuteQuery(sqlCommand, new SqlParameter[] { parameter });
            int count = (int)command.ExecuteScalar();
            db.closeConnection();


            if (count == 0)
            {

                //Insert Reservation Table
                string sqlCommand2 = "INSERT INTO Reservation (reservationID, reservationAmount, discountAmount, reservationTotal,checkInDate,checkOutDate,createdAt,reservationStatus, custID, propertyID) " +
                    "VALUES (@reservationID, @reservationAmount, @discountAmount, @reservationTotal, @checkInDate, @checkOutDate, @createdAt,@reservationStatus, @custID, @propertyID)";


                SqlParameter[] parameters2 =
                {
                new SqlParameter("@reservationID", Session["reservationID"]),
                new SqlParameter("@reservationAmount", reservationAmount),
                new SqlParameter("@discountAmount", discountAmount),
                new SqlParameter("@reservationTotal", totalAmount),
                new SqlParameter("@checkInDate", SqlDbType.DateTime) {Value = checkIn },
                new SqlParameter("@checkOutDate", SqlDbType.DateTime) {Value = checkOut },
                new SqlParameter("@createdAt", SqlDbType.DateTime) {Value = DateTime.Now },
                new SqlParameter("@reservationStatus", "Pending"),
                new SqlParameter("@custID", 1),
                new SqlParameter("@propertyID", propertyID)
            };

                db.createConnection();
                bool isBool = db.ExecuteNonQuery(sqlCommand2, parameters2);
                db.closeConnection();
            }



        }
        //private string generateReservationID()
        //{
        //    Random random = new Random();
        //    string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        //    string reservationID = "";

        //    bool codeExists = true;
        //    while (codeExists)
        //    {
        //        reservationID = new string(Enumerable.Repeat(characters, 40).Select(s => s[random.Next(s.Length)]).ToArray());
        //        codeExists = IsReservationIDExistsInDatabase(reservationID);
        //    }

        //    return reservationID;
        //}

        //private bool IsReservationIDExistsInDatabase(string reservationID)
        //{
        //    DBManager db = new DBManager();
        //    db.createConnection();

        //    string query = "SELECT COUNT(*) FROM Reservation WHERE reservationID = @reservationID";
        //    SqlParameter parameter = new SqlParameter("@reservationID", reservationID);
        //    SqlCommand command = db.ExecuteQuery(query, new SqlParameter[] { parameter });

        //    int count = (int)command.ExecuteScalar();
        //    db.closeConnection();

        //    return count > 0;
        //}



    }
}