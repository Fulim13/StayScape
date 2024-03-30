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
                // Initialize Stripe with your secret key
                string stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
                StripeConfiguration.ApiKey = stripeSecretKey;

                // Handle the POST request to create a payment intent
                var options = new PaymentIntentCreateOptions
                {
                    PaymentMethodTypes = new System.Collections.Generic.List<string> { "card", "fpx" },
                    Amount = 1099, // Adjust the amount as needed
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