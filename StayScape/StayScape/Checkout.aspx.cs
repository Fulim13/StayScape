using System;

namespace StayScape
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Store Property ID to Session
            Session["PropertyID"] = 1;

            Session["CheckIn"] = DateTime.Now;
            Session["CheckOut"] = DateTime.Now.AddDays(1);
            Session["reservationAmount"] = 10.99;
            Session["discountAmount"] = 0;


        }
    }
}