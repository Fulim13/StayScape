using System;
using System.Collections.Generic;
using System.Data;

namespace StayScape
{
    public partial class Voucher : System.Web.UI.Page
    {
        //const string query = "Select * FROM [Voucher]";

        //protected override void OnPreRender(EventArgs e)
        //{
        //    base.OnPreRender(e);
        //    if (IsPostBack)
        //    {
        //        try
        //        {
        //            if (txtSearch.Text != "" && ddlIsExpired.SelectedIndex != 0)
        //            {
        //                SqlDataSource1.SelectCommand = query + " WHERE voucherName LIKE '%' + @voucherName + '%'";
        //                if (ddlIsExpired.SelectedValue == "active")
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate >= @today AND activeStatus = True ";

        //                }
        //                else if (ddlIsExpired.SelectedValue == "inactive")
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate >= @today AND activeStatus = False ";
        //                }
        //                else
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate < @today ";
        //                }
        //                SqlDataSource1.SelectParameters.Clear();
        //                SqlDataSource1.SelectParameters.Add("voucherName", txtSearch.Text);
        //                SqlDataSource1.SelectParameters.Add("today", DbType.Date, DateTime.Now.Date.ToString("yyyy-MM-dd"));

        //            }
        //            else if (ddlIsExpired.SelectedIndex != 0)
        //            {
        //                if (ddlIsExpired.SelectedValue == "active")
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate >= @today AND activeStatus = True ";

        //                }
        //                else if (ddlIsExpired.SelectedValue == "inactive")
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate >= @today AND activeStatus = False ";
        //                }
        //                else
        //                {
        //                    SqlDataSource1.SelectCommand += " WHERE expiredDate < @today ";
        //                }
        //                SqlDataSource1.SelectParameters.Clear();
        //                SqlDataSource1.SelectParameters.Add("today", DbType.Date, DateTime.Now.Date.ToString("yyyy-MM-dd"));
        //            }
        //            else if (txtSearch.Text != "")
        //            {
        //                SqlDataSource1.SelectCommand = query + " WHERE voucherName LIKE '%' + @voucherName + '%'";
        //                SqlDataSource1.SelectParameters.Clear();
        //                SqlDataSource1.SelectParameters.Add("voucherName", txtSearch.Text);
        //            }
        //            else
        //            {
        //                SqlDataSource1.SelectCommand = query;
        //                SqlDataSource1.SelectParameters.Clear();
        //            }

        //            ListView1.DataBind();
        //        }
        //        catch (Exception ex)
        //        {
        //            System.Diagnostics.Debug.WriteLine(ex.Message + "\n" + query + "\n" + SqlDataSource1.SelectCommand);
        //        }
        //    }
        //}

        //const string query = "SELECT Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode,Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt, COUNT(Redemption.redemptionID) AS TotalRedemptions FROM Voucher LEFT JOIN Redemption ON Voucher.voucherID = Redemption.voucherID GROUP BY Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode, Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt";
        string baseQuery = "SELECT Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode,Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt, COUNT(Redemption.redemptionID) AS TotalRedemptions FROM Voucher LEFT JOIN Redemption ON Voucher.voucherID = Redemption.voucherID";
        string groupBy = "GROUP BY Voucher.voucherID, Voucher.voucherName, Voucher.totalVoucher, Voucher.startDate, Voucher.expiredDate, Voucher.minSpend, Voucher.voucherCode, Voucher.activeStatus, Voucher.discountType, Voucher.discountRate, Voucher.discountPrice, Voucher.capAt";

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (IsPostBack)
            {
                try
                {
                    SqlDataSource1.SelectCommand = baseQuery;
                    SqlDataSource1.SelectParameters.Clear();

                    List<string> conditions = new List<string>();

                    if (txtSearch.Text != "")
                    {
                        conditions.Add("voucherName LIKE '%' + @voucherName + '%'");
                        SqlDataSource1.SelectParameters.Add("voucherName", txtSearch.Text);
                    }

                    if (ddlIsExpired.SelectedIndex != 0)
                    {
                        if (ddlIsExpired.SelectedValue == "active")
                        {
                            conditions.Add("expiredDate >= @today AND activeStatus = 1");
                        }
                        else if (ddlIsExpired.SelectedValue == "inactive")
                        {
                            conditions.Add("expiredDate >= @today AND activeStatus = 0");
                        }
                        else
                        {
                            conditions.Add("expiredDate < @today");
                        }
                        SqlDataSource1.SelectParameters.Add("today", DbType.DateTime, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    }

                    if (conditions.Count > 0)
                    {
                        SqlDataSource1.SelectCommand = baseQuery + " WHERE " + string.Join(" AND ", conditions) + " " + groupBy;
                    }
                    else
                    {
                        SqlDataSource1.SelectCommand = baseQuery + " " + groupBy;
                    }

                    ListView1.DataBind();
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message + "\n" + baseQuery + "\n" + SqlDataSource1.SelectCommand);
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (HasVoucher())
                {
                    DisplayVouchersTable();

                }
                else
                {
                    DisplayNewVoucherSection();
                }
            }
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlIsExpired_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private bool HasVoucher()
        {
            DBManager dbConnection = new DBManager();
            string sqlCommand = "SELECT COUNT(*) FROM Voucher";
            dbConnection.createConnection();
            int count = dbConnection.ExecuteScalar(sqlCommand);
            return count > 0;
        }

        private void DisplayVouchersTable()
        {
            vouchersTable.Visible = true;
        }

        private void DisplayNewVoucherSection()
        {
            newVoucherSection.Visible = true;
        }

        protected string GetDiscountDetailFromValue(decimal minSpend, decimal discountPrice)
        {
            return $"Discount would be: RM{discountPrice}<br />If order value reaches: RM{minSpend}";
        }

        protected string GetDiscountDetailFromDiscount(decimal minSpend, decimal discountRate, decimal capAt)
        {
            return $"Discount would be: {discountRate}% Cap At RM{capAt}<br />If order value reaches: RM{minSpend}";
        }

        protected string GetStatusLabelCss(bool isActive, DateTime expiredDate)
        {
            string inlineStyles = "display: inline-flex; border-radius: 9999px; padding: 0.5rem 1rem; font-size: 0.75rem; font-weight: 600; line-height: 1.5; ";

            if (expiredDate < DateTime.Now)
            {
                inlineStyles += "background-color: #d1d5db; color: #4b5563;";
            }
            else if (isActive)
            {
                inlineStyles += "background-color: #d1fae5; color: #065f46;";
            }
            else
            {
                inlineStyles += "background-color: #feb2b2; color: #7f1d1d;";
            }

            return inlineStyles;
        }

        protected string GetStatusLabelText(bool isActive, DateTime expiredDate)
        {
            if (expiredDate < DateTime.Now)
            {
                return "Expired";
            }
            else if (isActive)
            {
                return "Active";
            }
            else
            {
                return "Inactive";
            }
        }
    }
}