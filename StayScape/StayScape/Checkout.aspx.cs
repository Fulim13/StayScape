using Stripe;
using System;

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
            var optionsProduct = new Stripe.ProductCreateOptions
            {
                Name = "T-Shirt",
            };
            var serviceProduct = new ProductService();
            Product product = serviceProduct.Create(optionsProduct);
            Console.Write("Success! Here is your starter subscription product id: {0}\n", product.Id);

            var optionsPrice = new PriceCreateOptions
            {
                UnitAmount = 1200,
                Currency = "myr",
                Product = product.Id
            };
            var servicePrice = new PriceService();
            Price price = servicePrice.Create(optionsPrice);
        }
    }
}