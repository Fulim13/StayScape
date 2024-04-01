using System;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class ReviewForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            thanksModal.CssClass = thanksModal.CssClass.Replace("hidden", "");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/OrderHistory.aspx");
        }

        protected void ModalCloseButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/OrderHistory.aspx");
        }

        protected void RatingButton_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            if (button.CssClass.Contains("selected"))
            {
                button.CssClass = button.CssClass.Replace("selected", "").Trim();
            }
            else
            {
                button.CssClass += " selected";
            }
        }
    }
}