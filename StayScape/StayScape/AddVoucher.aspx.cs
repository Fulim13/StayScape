using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class AddVoucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set the initial value only when the page is loaded for the first time
                //txtTotalVoucher.Text = "50";
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // reset the form
            txtVoucherName.Text = "";
            txtVoucherCode.Text = "";
            txtTotalVoucher.Text = "";
            txtRedeemLimit.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtMinSpend.Text = "";
            txtDiscountRate.Text = "";
            txtDiscountValue.Text = "";
            txtCapAt.Text = "";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // TODO: Replace session user id
            int userId = 1;

            // Insert Voucher

        }

    }
}