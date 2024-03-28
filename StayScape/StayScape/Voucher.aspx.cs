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
                bool hasVouchers = CheckForVouchers();

                if (hasVouchers)
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

        private bool CheckForVouchers()
        {
            // Implement your logic to check if there are vouchers in the database
            // For example, execute a SQL query to count the number of vouchers
            // Return true if vouchers exist, false otherwise

            // Example query:
            // SELECT COUNT(*) FROM Voucher;

            // For demonstration purpose, let's assume there are vouchers
            DBConnection dbConnection = new DBConnection();
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

    }
}