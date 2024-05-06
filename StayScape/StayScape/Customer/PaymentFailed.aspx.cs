using System;

namespace StayScape
{
    public partial class PaymentFailed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnTryAgain_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }

        protected void btnOrderHistoryPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderHistory.aspx");
        }
    }
}