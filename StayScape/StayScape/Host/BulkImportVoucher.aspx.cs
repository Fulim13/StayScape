using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;

namespace StayScape
{
    public partial class BulkImportVoucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            // Generate CSV content
            StringBuilder csvContent = new StringBuilder();
            // Add CSV header
            csvContent.AppendLine("voucherName,totalVoucher,redeemLimitPerCustomer,startDate,expiredDate,discountType,minSpend,discountRate,discountPrice,capAt"); // Replace with your CSV headers

            // Add CSV rows
            csvContent.AppendLine("Example Money Value Off,6026,8,2024-01-24 23:20:27,2024-10-05 18:20:29,Money Value Off,4939.71,,60.37,");
            csvContent.AppendLine("Example Percentage Discount Off,6026,8,2024-01-24 23:20:27,2024-10-05 18:20:29,Percentage Discount Off,4939.71,152.53,,10");

            // Set response headers
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=voucher.csv");
            Response.Charset = "";
            Response.ContentType = "application/text";

            // Write CSV content to response stream
            Response.Output.Write(csvContent.ToString());
            Response.Flush();
            Response.End();
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string filePath = Server.MapPath("~/Uploads/" + fileName);
                FileUpload1.SaveAs(filePath);

                // Process the uploaded CSV file
                CSVReader.ProcessCSV(filePath, ProcessRow);

                // Optionally, delete the uploaded file after processing
                File.Delete(filePath);
            }
        }

        private void ProcessRow(string[] fields)
        {
            GenerateVoucher voucherGenerator = new GenerateVoucher();

            // Assuming fields array contains data from CSV columns
            string voucherName = fields[0];
            int totalVoucher = Convert.ToInt32(fields[1]);
            int redeemLimit = Convert.ToInt32(fields[2]);
            DateTime startDate = Convert.ToDateTime(fields[3]);
            DateTime endDate = Convert.ToDateTime(fields[4]);
            string discountType = fields[5];

            decimal minSpend = 0;
            if (fields[6] != "")
            {
                minSpend = Convert.ToDecimal(fields[6]);
            }

            decimal discountRate = 0;
            if (fields[7] != "")
            {
                discountRate = Convert.ToDecimal(fields[7]);
            }
            decimal discountPrice = 0;
            if (fields[8] != "")
            {
                discountPrice = Convert.ToDecimal(fields[8]);
            }

            decimal capAt = 0;
            if (fields[9] != "")
            {
                capAt = Convert.ToDecimal(fields[9]);
            }
            //TODO: Left with propertyID

            DBManager dbConnection = new DBManager();

            string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate, activeStatus, discountType, minSpend, discountRate, discountPrice, capAt, createdBy, hostID) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @activeStatus, @discountType, @minSpend, @discountRate, @discountPrice, @capAt, @createdBy, @hostID)";
            SqlParameter[] parameters;

            if (discountType == "Money Value Off")
            {
                parameters = new SqlParameter[]
                {
                    new SqlParameter("@voucherName", voucherName),
                    new SqlParameter("@voucherCode", voucherGenerator.generateVoucherCode()),
                    new SqlParameter("@totalVoucher", totalVoucher),
                    new SqlParameter("@redeemLimitPerCustomer", redeemLimit),
                    new SqlParameter("@startDate", SqlDbType.DateTime) { Value = startDate },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) { Value = endDate },
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Value Off"),
                    new SqlParameter("@minSpend", minSpend),
                    new SqlParameter("@discountPrice", discountPrice),
                    new SqlParameter("@discountRate", DBNull.Value),
                    new SqlParameter("@capAt", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) { Value = DateTime.Now },
                    new SqlParameter("@hostID", 1), // TODO: Replace with actual host ID
                };
            }
            else
            {
                parameters = new SqlParameter[]
                {
                    new SqlParameter("@voucherName", voucherName),
                    new SqlParameter("@voucherCode", voucherGenerator.generateVoucherCode()),
                    new SqlParameter("@totalVoucher", totalVoucher),
                    new SqlParameter("@redeemLimitPerCustomer", redeemLimit),
                    new SqlParameter("@startDate", SqlDbType.DateTime) { Value = startDate },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) { Value = endDate },
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Discount Off"),
                    new SqlParameter("@minSpend", minSpend),
                    new SqlParameter("@discountPrice", DBNull.Value),
                    new SqlParameter("@discountRate", discountRate),
                    new SqlParameter("@capAt", capAt),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) { Value = DateTime.Now },
                    new SqlParameter("@hostID", 1), // TODO: Replace with actual host ID
                };
            }

            dbConnection.createConnection();

            bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
            dbConnection.closeConnection();
        }
    }
}