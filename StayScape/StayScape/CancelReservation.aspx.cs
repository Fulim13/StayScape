using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class CancelReservation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void reasonRbl_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (reasonRbl.SelectedValue == "Other")
            {
                reasonTxtbx.Visible = true;
            }
            else
            {
                reasonTxtbx.Visible = false;
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string strError = "";
            if (string.IsNullOrEmpty(reasonRbl.SelectedValue))
            {
                strError = "Please select a cancellation reason!";
                lblError.Text = strError;
            }
            else { 
            pendingApprovalModal.CssClass = pendingApprovalModal.CssClass.Replace("hidden", "");
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Dashboard.aspx");
        }

        protected void ModalCloseButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Dashboard.aspx");
        }
    }
}