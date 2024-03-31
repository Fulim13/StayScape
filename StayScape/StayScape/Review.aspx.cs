using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class Review : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReply_Click(object sender, EventArgs e)
        {
            replyTextBox.Visible = true;
            btnSubmitReply.Visible = true;
            btnCancel.Visible = true;
        }

        protected void btnSubmitReply_Click(object sender, EventArgs e)
        {
            replyModal.CssClass = replyModal.CssClass.Replace("hidden", "");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            replyTextBox.Visible = false;
            btnSubmitReply.Visible = false;
            btnCancel.Visible = false;
        }

        protected void ModalCloseButton_Click(object sender, EventArgs e)
        {
            replyModal.CssClass += " hidden";
            replyTextBox.Visible = false;
            btnSubmitReply.Visible = false;
            btnCancel.Visible = false;
        }

        protected void RatingButton_Click(object sender, EventArgs e)
        {
            Button clickedButton = (Button)sender;

            // Enable all buttons
            btn5Star.Enabled = true;
            btn4Star.Enabled = true;
            btn3Star.Enabled = true;
            btn2Star.Enabled = true;
            btn1Star.Enabled = true;

            // Remove 'selected' class from all buttons
            btnAll.CssClass = btnAll.CssClass.Replace("selected", "").Trim();
            btn5Star.CssClass = btn5Star.CssClass.Replace("selected", "").Trim();
            btn4Star.CssClass = btn4Star.CssClass.Replace("selected", "").Trim();
            btn3Star.CssClass = btn3Star.CssClass.Replace("selected", "").Trim();
            btn2Star.CssClass = btn2Star.CssClass.Replace("selected", "").Trim();
            btn1Star.CssClass = btn1Star.CssClass.Replace("selected", "").Trim();

            if (clickedButton.ID == "btnAll")
            {
                // Disable all other rating buttons
                foreach (Control control in this.Controls)
                {
                    if (control is Button && control != clickedButton)
                    {
                        ((Button)control).Enabled = false;
                    }
                }
            }
            else
            {
                // Add 'selected' class to the clicked button
                clickedButton.CssClass += " selected";
            }
        }

    }
}