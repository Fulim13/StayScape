using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class AddVoucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProperty();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Voucher.aspx");
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

        protected void CustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Your validation logic here
        }

        protected void chkMoneyValueOff_CheckedChanged(object sender, EventArgs e)
        {
            // Implement your toggle functionality here
            RequiredFieldValidator5.ValidationGroup = "VoucherValidation";
            rfvDisRate.ValidationGroup = "";
            RequiredFieldValidator4.ValidationGroup = "";
        }

        protected void chkPercentageDiscountOff_CheckedChanged(object sender, EventArgs e)
        {
            // Implement your toggle functionality here
            RequiredFieldValidator5.ValidationGroup = "";
            rfvDisRate.ValidationGroup = "VoucherValidation";
            RequiredFieldValidator4.ValidationGroup = "VoucherValidation";
        }

        private void resetFields()
        {
            // reset the form
            txtVoucherName.Text = "";
            txtTotalVoucher.Text = "";
            txtRedeemLimit.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtMinSpend.Text = "";
            txtDiscountRate.Text = "";
            txtDiscountValue.Text = "";
            txtCapAt.Text = "";
        }



        private void LoadProperty()
        {
            DBManager dbConnection = new DBManager();
            dbConnection.createConnection();

            string query = "SELECT propertyID, propertyName FROM Property WHERE hostID = @hostID";

            SqlCommand command = dbConnection.ExecuteQuery(query);
            command.Parameters.AddWithValue("@hostID", Session["hostID"].ToString());

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

                // TODO: Validation for no properties available
                ddlHostProperty.Items.Insert(0, new ListItem("Select Property", ""));
                ddlHostProperty.Enabled = true;
            }
            else
            {
                // Handle the case when no properties are available
                ddlHostProperty.Items.Clear();
                ddlHostProperty.Items.Insert(0, new ListItem("No properties available", ""));
                ddlHostProperty.Enabled = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                GenerateVoucher voucherGenerator = new GenerateVoucher();



                DBManager dbConnection = new DBManager();

                string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate, activeStatus, discountType, minSpend, discountRate, discountPrice, capAt, createdBy, hostID, propertyID) " +
                    "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @activeStatus, @discountType, @minSpend, @discountRate, @discountPrice, @capAt, @createdBy, @hostID, @propertyID)";
                SqlParameter[] parameters;

                string selectedValue = rbSpecific.Checked && ddlHostProperty != null && ddlHostProperty.Items.Count > 1 ? ddlHostProperty.SelectedValue : "";

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
                    new SqlParameter("@voucherCode", voucherGenerator.generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Value Off"),
                    new SqlParameter("@discountRate", DBNull.Value),
                    new SqlParameter("@capAt", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", Session["hostID"].ToString()),
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
                    new SqlParameter("@voucherCode", voucherGenerator.generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Discount Off"),
                    new SqlParameter("@discountPrice", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", Session["hostID"].ToString()),
                    selectedValue != "" ? new SqlParameter("@propertyID",  Convert.ToInt32(selectedValue)): new SqlParameter("@propertyID",DBNull.Value)
                    };
                }

                dbConnection.createConnection();
                bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
                dbConnection.closeConnection();
                resetFields();
                Response.Redirect("Voucher.aspx");
            }
        }

    }
}