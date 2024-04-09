using System;

namespace StayScape.errors
{
    public partial class _404 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/property_list.aspx");
        }
    }
}