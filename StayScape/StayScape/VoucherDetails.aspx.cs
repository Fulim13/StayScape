using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class VoucherDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["voucherID"] == null)
            {
                //Panel1.Visible = false;
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadProperty();
                    fetchData();
                }
            }
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

        private void LoadProperty()
        {
            DBManager dbConnection = new DBManager();
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

                // TODO: Validation for no properties available
                ddlHostProperty.Items.Insert(0, new ListItem("Select Property", ""));
            }
            else
            {
                // Handle the case when no properties are available
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DBManager db = new DBManager();

                string sqlCommand = "UPDATE Voucher SET" +
                    " voucherName = @voucherName," +
                    " totalVoucher = @totalVoucher," +
                    " redeemLimitPerCustomer = @redeemLimitPerCustomer," +
                    " discountType = @discountType," +
                    " minSpend = @minSpend," +
                    " discountRate = @discountRate," +
                    " discountPrice = @discountPrice," +
                    " capAt = @capAt " +
                    " WHERE voucherID = @voucherID";
                SqlParameter[] parameters;

                if (hdnDiscountType.Value == "Money Value Off")
                {
                    parameters = new SqlParameter[]
                    {
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@discountType", "Value Off"),
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@voucherID", Request.QueryString["voucherID"]),
                    new SqlParameter("@discountPrice", Convert.ToDouble(txtDiscountValue.Text)),
                    new SqlParameter("@discountRate", DBNull.Value),
                    new SqlParameter("@capAt", DBNull.Value)
                    };

                }
                else
                {
                    parameters = new SqlParameter[]
                    {
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@discountType", "Discount Off"),
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@voucherID", Request.QueryString["voucherID"]),
                    new SqlParameter("@discountPrice", DBNull.Value),
                    new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text)),
                    new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text))
                    };
                }

                db.createConnection();
                bool valid = db.ExecuteNonQuery(sqlCommand, parameters);
                db.closeConnection();
                if (valid)
                {
                    Response.Redirect("~/Voucher.aspx");
                }
            }
        }

        protected void btnDeactivate_Click(object sender, EventArgs e)
        {

            //Check if the voucher is active or not
            if (btnSubmit.Text == "Activate")
            {
                DBManager db = new DBManager();

                string sqlCommand = "UPDATE Voucher SET" +
                    " activeStatus = 1 WHERE voucherID = @voucherID";

                SqlParameter[] parameters =
                {
                    new SqlParameter("@voucherID", Request.QueryString["voucherID"]),
                };

                db.createConnection();
                bool valid = db.ExecuteNonQuery(sqlCommand, parameters);
                db.closeConnection();
                if (valid)
                {
                    Response.Redirect("~/Voucher.aspx");
                }
            }
            else
            {
                DBManager db = new DBManager();

                string sqlCommand = "UPDATE Voucher SET" +
                    " activeStatus = 0 WHERE voucherID = @voucherID";

                SqlParameter[] parameters =
                {
                new SqlParameter("@voucherID", Request.QueryString["voucherID"]),
            };

                db.createConnection();
                bool valid = db.ExecuteNonQuery(sqlCommand, parameters);
                db.closeConnection();
                if (valid)
                {
                    Response.Redirect("~/Voucher.aspx");
                }
            }

        }


        private void fetchData()
        {
            DBManager db = new DBManager();
            db.createConnection();

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@voucherID", Request.QueryString["voucherID"])
            };

            SqlDataReader voucherDetails = db.ExecuteQuery("SELECT * FROM Voucher WHERE voucherID = @voucherID", parameters).ExecuteReader();

            if (voucherDetails.HasRows)
            {
                voucherDetails.Read();
                // Populate textboxes with data from the SqlDataReader
                txtVoucherName.Text = voucherDetails["voucherName"].ToString();
                txtTotalVoucher.Text = voucherDetails["totalVoucher"].ToString();
                txtRedeemLimit.Text = voucherDetails["redeemLimitPerCustomer"].ToString();
                txtMinSpend.Text = voucherDetails["minSpend"].ToString();
                btnSubmit.Text = voucherDetails["activeStatus"].ToString() == "True" ? "Deactivate" : "Activate";

                // Populate start and end dates
                txtStartDate.Text = Convert.ToDateTime(voucherDetails["startDate"]).ToString("yyyy-MM-ddTHH:mm");
                txtEndDate.Text = Convert.ToDateTime(voucherDetails["expiredDate"]).ToString("yyyy-MM-ddTHH:mm");

                // Determine which radio button is selected
                object propertyIDObject = voucherDetails["propertyID"];
                if (propertyIDObject != DBNull.Value)
                {
                    rbSpecific.Checked = true;
                    pnlHostProperty.Visible = true;
                    ddlHostProperty.SelectedValue = propertyIDObject.ToString();
                }
                else
                {
                    rbAll.Checked = true;
                    pnlHostProperty.Visible = false;
                }

                // Determine which discount type is selected and populate the corresponding textbox
                string discountType = voucherDetails["discountType"].ToString();
                if (discountType == "Value Off")
                {
                    hdnDiscountType.Value = "Money Value Off";
                    //string script = "<script>toggleLabels();</script>";
                    //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallToggleLabels", script);
                    txtDiscountValue.Text = voucherDetails["discountPrice"].ToString();
                }
                else if (discountType == "Discount Off")
                {
                    hdnDiscountType.Value = "Percentage Discount Off";
                    string script = "<script>toggleLabels();</script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallToggleLabels", script);
                    txtDiscountRate.Text = voucherDetails["discountRate"].ToString();
                    txtCapAt.Text = voucherDetails["capAt"].ToString();
                }
                txtStartDate.Enabled = false;
                txtEndDate.Enabled = false;
                ddlHostProperty.Enabled = false;
                rbAll.Enabled = false;
                rbSpecific.Enabled = false;
            }
            db.closeConnection();
        }
    }
}