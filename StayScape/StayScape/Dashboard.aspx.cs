using System;

namespace StayScape
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Create host session
            Session["hostID"] = 1;
        }

        protected string GetStatusLabelCss(string status)
        {
            string inlineStyles = "display: inline-flex; border-radius: 9999px; padding: 0.5rem 1rem; font-size: 0.75rem; font-weight: 600; line-height: 1.5; ";
            if (status == "Paid")
            {
                inlineStyles += "background-color: #d1fae5; color: #065f46;";
            }
            else if (status == "Failed")
            {
                inlineStyles += "background-color: #d1d5db; color: #4b5563;";
            }
            else
            {
                inlineStyles += "background-color: #feb2b2; color: #7f1d1d;";
            }

            return inlineStyles;
        }
    }
}