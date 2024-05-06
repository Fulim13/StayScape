using System;
using System.Data.SqlClient;
using System.Linq;

namespace StayScape
{
    public class GenerateVoucher
    {
        public string generateVoucherCode()
        {
            Random random = new Random();
            string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            string voucherCode = "";

            bool codeExists = true;
            while (codeExists)
            {
                voucherCode = new string(Enumerable.Repeat(characters, 8).Select(s => s[random.Next(s.Length)]).ToArray());
                codeExists = IsVoucherCodeExistsInDatabase(voucherCode);
            }

            return voucherCode;
        }

        private bool IsVoucherCodeExistsInDatabase(string voucherCode)
        {
            DBManager dbConnection = new DBManager();
            dbConnection.createConnection();

            string query = "SELECT COUNT(*) FROM Voucher WHERE voucherCode = @voucherCode";
            SqlParameter parameter = new SqlParameter("@voucherCode", voucherCode);
            SqlCommand command = dbConnection.ExecuteQuery(query, new SqlParameter[] { parameter });

            int count = (int)command.ExecuteScalar();
            dbConnection.closeConnection();

            return count > 0;
        }
    }
}