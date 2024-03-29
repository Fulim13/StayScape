using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class Voucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (hasVoucher())
                {
                    DisplayVouchersTable();
                    //DisplayNewVoucherSection();

                }
                else
                {
                    DisplayNewVoucherSection();
                }
            }
        }

        private bool hasVoucher()
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
                inlineStyles += "background-color: #feb2b2; color: #7f1d1d;";
            }
            else if (isActive)
            {
                inlineStyles += "background-color: #d1fae5; color: #065f46;";
            }
            else
            {
                inlineStyles += "background-color: #d1d5db; color: #4b5563;";
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