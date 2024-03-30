using Newtonsoft.Json;
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;

namespace StayScape
{
    /// <summary>
    /// Summary description for CheckPaymentStatus
    /// </summary>
    public class CheckPaymentStatus : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {



            context.Response.ContentType = "application/json";
            string requestBody;
            using (var reader = new System.IO.StreamReader(context.Request.InputStream))
            {
                requestBody = reader.ReadToEnd();
            }

            // Deserialize the JSON payload to get the payment status
            bool paymentStatus = JsonConvert.DeserializeObject<bool>(requestBody);
            string paymentMessage = "";
            if (paymentStatus)
            {
                // Insert payment details into the database
                DBManager db = new DBManager();

                string sqlCommand = "INSERT INTO Payment (paymentID, paymentDate,reservationID) " +
                    "VALUES (@paymentID, @paymentDate, @reservationID)";
                //context.Session["reservationID"] = "1234567890";
                //Console.WriteLine("Reservation ID: " + context.Session["reservationID"]);
                string reservationID = Convert.ToString(context.Session["reservationID"]);


                SqlParameter[] parameters =
                {
                new SqlParameter("@paymentID", Guid.NewGuid().ToString()),
                new SqlParameter("@paymentDate", DateTime.Now),
                new SqlParameter("@reservationID", reservationID),
                };

                db.createConnection();
                bool isBool = db.ExecuteNonQuery(sqlCommand, parameters);
                db.closeConnection();
                paymentMessage = "Payment successful!";

                //Update reservation status
                string updateReservationStatus = "UPDATE Reservation SET reservationStatus = 'Paid' WHERE reservationID = @reservationID";
                SqlParameter[] updateParameters =
                {
                    new SqlParameter("@reservationID", reservationID)
                };
                db.createConnection();
                bool isUpdated = db.ExecuteNonQuery(updateReservationStatus, updateParameters);
                db.closeConnection();
            }
            else
            {
                //Update reservation status
                string reservationID = Convert.ToString(context.Session["reservationID"]);

                string updateReservationStatus = "UPDATE Reservation SET reservationStatus = 'Failed' WHERE reservationID = @reservationID";
                SqlParameter[] updateParameters =
                {
                    new SqlParameter("@reservationID", reservationID)
                };
                DBManager db = new DBManager();
                db.createConnection();
                bool isUpdated = db.ExecuteNonQuery(updateReservationStatus, updateParameters);
                db.closeConnection();
                paymentMessage = "Payment failed!";
            }

            // Prepare JSON response object
            var responseObj = new
            {
                paymentMessage = paymentMessage
            };

            // Serialize the response object to JSON format
            string jsonResponse = Newtonsoft.Json.JsonConvert.SerializeObject(responseObj);

            // Write the JSON response to the client
            context.Response.Write(jsonResponse);


        }

        private void InsertPayment()
        {

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
