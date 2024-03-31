using Newtonsoft.Json;
using Stripe;
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
            var paymentIntent = JsonConvert.DeserializeObject<PaymentIntent>(requestBody);
            string paymentMessage = "";
            if (paymentIntent != null && paymentIntent.status == "succeeded")
            {
                //Get Payment Method from the paymentIntent object
                string paymentMethod = paymentIntent.payment_method;
                // Initialize Stripe with your secret key
                string stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
                StripeConfiguration.ApiKey = stripeSecretKey;

                // Retrieve the payment intent object
                var service = new PaymentMethodService();
                var paymentIntentObj = service.Get(paymentMethod);

                // Retrieve the payment type
                string paymentType = paymentIntentObj.Type;

                string cardBrand = "";
                string cardLast4 = "";
                string cardExpMonth = "";
                string cardExpYear = "";
                string fpxBank = "";
                if (paymentType == "card")
                {
                    // Retrieve the card details
                    var card = paymentIntentObj.Card;
                    cardBrand = card.Brand;
                    cardLast4 = card.Last4;
                    cardExpMonth = card.ExpMonth.ToString();
                    cardExpYear = card.ExpYear.ToString();
                }
                else if (paymentType == "fpx")
                {
                    // Retrieve the FPX details
                    var fpx = paymentIntentObj.Fpx;
                    fpxBank = fpx.Bank;
                }



                // Insert payment details into the database
                DBManager db = new DBManager();

                string sqlCommand = "INSERT INTO Payment (paymentID, paymentMethod, paymentMethodDetail, paymentDate,reservationID) " +
                    "VALUES (@paymentID, @paymentMethod, @paymentMethodDetail, @paymentDate, @reservationID)";
                string reservationID = Convert.ToString(context.Session["reservationID"]);


                SqlParameter[] parameters =
                {
                new SqlParameter("@paymentID", Guid.NewGuid().ToString()),
                new SqlParameter("@paymentMethod", paymentType),
                paymentType == "card" ?
                    new SqlParameter("@paymentMethodDetail", cardBrand + " Ending with " + cardLast4 + " Expires" + cardExpMonth + "/" + cardExpYear)
                    : paymentType == "fpx" ?
                    new SqlParameter("@paymentMethodDetail", fpxBank) :
                    new SqlParameter("@paymentMethodDetail",DBNull.Value),
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

        public class PaymentIntent
        {
            public string payment_method { get; set; }
            public string status { get; set; }
        }
    }
}
