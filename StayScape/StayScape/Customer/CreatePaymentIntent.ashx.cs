using Newtonsoft.Json;
using Stripe;
using System;
using System.Web;

namespace StayScape
{
    /// <summary>
    /// Summary description for CreatePaymentIntent
    /// </summary>
    public class CreatePaymentIntent : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";

            if (context.Request.HttpMethod == "POST")
            {
                string stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
                StripeConfiguration.ApiKey = stripeSecretKey;

                string requestBody;
                using (var reader = new System.IO.StreamReader(context.Request.InputStream))
                {
                    requestBody = reader.ReadToEnd();
                }

                // Deserialize the JSON payload to get the amount
                dynamic requestData = JsonConvert.DeserializeObject(requestBody);
                int amount = requestData?.amount ?? 0; // Default to 0 if amount is not provided

                // Handle the POST request to create a payment intent
                var options = new PaymentIntentCreateOptions
                {
                    PaymentMethodTypes = new System.Collections.Generic.List<string> { "card", "fpx", "grabpay" },
                    Amount = amount, // Adjust the amount as needed
                    Currency = "myr",
                };
                var service = new PaymentIntentService();
                var paymentIntent = service.Create(options);

                // Return the client secret of the created payment intent as JSON
                context.Response.Write($"{{ \"clientSecret\": \"{paymentIntent.ClientSecret}\" }}");
            }
            else
            {
                context.Response.StatusCode = 405; // Method Not Allowed
            }
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