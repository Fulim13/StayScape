using Microsoft.VisualBasic.FileIO;
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

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string filePath = Server.MapPath("~/Uploads/" + fileName);
                FileUpload1.SaveAs(filePath);

                // Process the uploaded CSV file
                ProcessCSV(filePath);

                // Optionally, delete the uploaded file after processing
                File.Delete(filePath);
            }
        }

        private void ProcessCSV(string filePath)
        {
            using (TextFieldParser parser = new TextFieldParser(filePath))
            {
                parser.TextFieldType = FieldType.Delimited;
                parser.SetDelimiters(",");

                // Skip header row if present
                if (!parser.EndOfData)
                {
                    parser.ReadLine(); // Skip header row
                }

                // Read and process each row of data
                while (!parser.EndOfData)
                {
                    string[] fields = parser.ReadFields();
                    if (fields != null)
                    {
                        // Process the fields (e.g., insert into database)
                        ProcessRow(fields);
                    }
                }
            }
        }

        private void ProcessRow(string[] fields)
        {
            // Assuming fields array contains data from CSV columns
            string voucherName = fields[0];
            string voucherCode = fields[1];
            int totalVoucher = Convert.ToInt32(fields[2]);
            int redeemLimit = Convert.ToInt32(fields[3]);
            DateTime startDate = Convert.ToDateTime(fields[4]);
            DateTime endDate = Convert.ToDateTime(fields[5]);
            decimal minSpend = Convert.ToDecimal(fields[6]);
            decimal discountRate = Convert.ToDecimal(fields[7]);
            decimal discountValue = Convert.ToDecimal(fields[8]);
            decimal capAt = Convert.ToDecimal(fields[9]);
            DateTime createdBy = Convert.ToDateTime(fields[10]);

            // Perform database operations (e.g., insert into database)
            // Example: 
            // InsertDataIntoDatabase(voucherName, voucherCode, totalVoucher, ...);
            // Connection to database
            DBConnection dbConnection = new DBConnection();

            string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate , minSpend, discountPrice, createdBy) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @minSpend, @discountPrice, @createdBy)";

            SqlParameter[] parameters =
            {
                    new SqlParameter("@voucherName", voucherName),
                    new SqlParameter("@voucherCode", voucherCode),
                    new SqlParameter("@totalVoucher", totalVoucher),
                    new SqlParameter("@redeemLimitPerCustomer", redeemLimit),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = startDate },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = endDate },
                    new SqlParameter("@minSpend", minSpend),
                    new SqlParameter("@discountPrice", discountValue),
                    //new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text) / 100),
                    //new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text)),        
                    //Current DateTime
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = createdBy },
            };
            dbConnection.createConnection();

            bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
            dbConnection.closeConnection();
        }
    }
}