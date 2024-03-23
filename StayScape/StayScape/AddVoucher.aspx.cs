using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;

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
            // TODO: Replace session host id
            int hostID = 1;

            // Connection to database
            DBConnection dbConnection = new DBConnection();



            // Insert Voucher
            if (hdnDiscountType.Value == "Money Value Off")
            {
                string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate , minSpend, discountPrice, createdBy) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @minSpend, @discountPrice, @createdBy)";

                SqlParameter[] parameters =
                {
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@voucherCode", txtVoucherCode.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountPrice", Convert.ToDouble(txtDiscountValue.Text)),
                    //new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text) / 100),
                    //new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text)),        
                    //Current DateTime
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID)
                };
                dbConnection.createConnection();

                bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
                dbConnection.closeConnection();
            }
            else if (hdnDiscountType.Value == "Percentage Discount Off")
            {
                string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate , minSpend, discountRate, capAt , createdBy) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @minSpend, @discountRate, @capAt, @createdBy)";

                SqlParameter[] parameters =
                {
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@voucherCode", txtVoucherCode.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text) / 100),
                    new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text)),        
                    //Current DateTime
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID)
                };
                dbConnection.createConnection();

                bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
                dbConnection.closeConnection();
            }

        }

    }
}