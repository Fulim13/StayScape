using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Security.Cryptography;

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
                LoadPropertyNames();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            resetFields();
        }

        protected void toggleDDLPanel_ValueChanged(object sender, EventArgs e)
        {
            if (rbAll.Checked)
            {
                pnlHostProperty.Visible = false;
            }
            else
            {
                pnlHostProperty.Visible = true;
            }
        }

        private void resetFields()
        {
            // reset the form
            txtVoucherName.Text = "";
            //txtVoucherCode.Text = "";
            txtTotalVoucher.Text = "";
            txtRedeemLimit.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtMinSpend.Text = "";
            txtDiscountRate.Text = "";
            txtDiscountValue.Text = "";
            txtCapAt.Text = "";
        }

        private string generateVoucherCode()
        {
            // Generate random voucher code
            Random random = new Random();
            string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            string voucherCode = new string(Enumerable.Repeat(characters, 8).Select(s => s[random.Next(s.Length)]).ToArray());
            return voucherCode;
        }

        private void LoadPropertyNames()
        {
            DBConnection dbConnection = new DBConnection();
            dbConnection.createConnection();

            string query = "SELECT propertyID, propertyName FROM Property";

            SqlCommand command = dbConnection.ExecuteQuery(query);

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable dt = new DataTable();

            adapter.Fill(dt);

            dbConnection.closeConnection();

            if (dt.Rows.Count > 0)
            {
                ddlHostProperty.DataSource = dt;
                ddlHostProperty.DataTextField = "propertyName";
                ddlHostProperty.DataValueField = "propertyID";
                ddlHostProperty.DataBind();

                // Optionally, you can add a default item to the DropDownList
                ddlHostProperty.Items.Insert(0, new ListItem("Select Property", ""));
            }
            else
            {
                // Handle the case when no properties are available
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // TODO: Replace session host id
            int hostID = 1;

            // Connection to database
            DBConnection dbConnection = new DBConnection();

            string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate, activeStatus, minSpend, discountRate, discountPrice, capAt, createdBy, hostID, propertyID) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @activeStatus, @minSpend, @discountRate, @discountPrice, @capAt, @createdBy, @hostID, @propertyID)";
            SqlParameter[] parameters;

            string selectedValue = rbSpecific.Checked && ddlHostProperty != null && ddlHostProperty.Items.Count > 1 ? ddlHostProperty.SelectedValue : "";


            // Insert Voucher
            if (hdnDiscountType.Value == "Money Value Off")
            {
                parameters = new SqlParameter[]
                {
                    // User Input Values
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountPrice", Convert.ToDouble(txtDiscountValue.Text)),
                    // Auto Generated Values
                    new SqlParameter("@voucherCode", generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountRate", DBNull.Value),
                    new SqlParameter("@capAt", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID),
                    selectedValue != "" ? new SqlParameter("@propertyID",  Convert.ToInt32(selectedValue)): new SqlParameter("@propertyID",DBNull.Value)
            };

            }
            else
            {
                parameters = new SqlParameter[]
                {
                    // User Input Values
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text)),
                    new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text)),
                    // Auto Generated Values
                    new SqlParameter("@voucherCode", generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountPrice", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID),
                    selectedValue != "" ? new SqlParameter("@propertyID",  Convert.ToInt32(selectedValue)): new SqlParameter("@propertyID",DBNull.Value)
                };
            }

            dbConnection.createConnection();
            bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
            dbConnection.closeConnection();

            resetFields();

        }

    }
}