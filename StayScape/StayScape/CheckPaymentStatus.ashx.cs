using Newtonsoft.Json;
using System.Web;

namespace StayScape
{
    /// <summary>
    /// Summary description for CheckPaymentStatus
    /// </summary>
    public class CheckPaymentStatus : IHttpHandler
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
                paymentMessage = "Payment successful!";
            }
            else
            {
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

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
