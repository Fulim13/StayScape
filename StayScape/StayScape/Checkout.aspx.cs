using Stripe;
using System;
using System.Collections.Generic;

namespace StayScape
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPlacePayment_Click(object sender, EventArgs e)
        {
            string stripeSecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
            StripeConfiguration.ApiKey = stripeSecretKey;
            var options = new PaymentIntentCreateOptions
            {
                PaymentMethodTypes = new List<string> { "fpx", "" },
                Amount = 1099,
                Currency = "myr",
            };
            var service = new PaymentIntentService();
            service.Create(options);
        }
    }
}