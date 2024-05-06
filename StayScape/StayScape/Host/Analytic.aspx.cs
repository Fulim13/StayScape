using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace StayScape
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "setArrSales", $"setArrSales({getSales()});", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "setArrTop5SalesByProperty", $"setArrTop5SalesByProperty({getTop5SalesByProperty()});", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "setArrSalesByCustomer", $"setArrSalesByCustomer({getSalesByCustomer()});", true);

            }
        }

        private string getSales()
        {
            decimal[] arr = new decimal[12];
            DBManager db = new DBManager();
            string query = @"SELECT MONTH(r.createdAt) AS month, SUM(r.reservationTotal) AS monthly_order_total 
                     FROM [Reservation] r 
                     INNER JOIN [Property] p ON r.propertyId = p.propertyId 
                     INNER JOIN [Host] h ON p.hostID = h.hostID
                     WHERE YEAR(r.createdAt) = @year AND r.reservationStatus = 'Paid' AND h.hostID = @hostID
                     GROUP BY MONTH(r.createdAt) 
                     ORDER BY MONTH(r.createdAt);";
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
        new SqlParameter("@year", DateTime.Now.Year),
        new SqlParameter("@hostID", Session["hostID"].ToString())
            };
            db.createConnection();
            SqlDataReader reader = db.ExecuteQuery(query, sqlParameters).ExecuteReader();
            while (reader.Read())
            {
                arr[Convert.ToInt32(reader["month"]) - 1] = Convert.ToDecimal(reader["monthly_order_total"]);

            }
            db.closeConnection();

            JavaScriptSerializer ser = new JavaScriptSerializer();
            string values = ser.Serialize(arr);
            return values;
        }

        private string getTop5SalesByProperty()
        {
            Dictionary<string, decimal> top5SalesByProperty = new Dictionary<string, decimal>();
            DBManager db = new DBManager();
            string query = @"SELECT TOP 5 p.propertyName, SUM(r.reservationTotal) AS total 
                     FROM [Reservation] r 
                     INNER JOIN [Property] p ON r.propertyId = p.propertyId 
                     INNER JOIN [Host] h ON p.hostID = h.hostID
                     WHERE YEAR(r.createdAt) = @year AND r.reservationStatus = 'Paid' AND h.hostID = @hostID
                     GROUP BY p.propertyName 
                     ORDER BY total DESC;";
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
        new SqlParameter("@year", DateTime.Now.Year),
        new SqlParameter("@hostID", Session["hostID"].ToString())
            };
            db.createConnection();
            SqlDataReader reader = db.ExecuteQuery(query, sqlParameters).ExecuteReader();
            while (reader.Read())
            {
                string propertyName = reader["propertyName"].ToString();
                decimal totalSales = Convert.ToDecimal(reader["total"]);
                top5SalesByProperty.Add(propertyName, totalSales);
            }
            db.closeConnection();

            JavaScriptSerializer ser = new JavaScriptSerializer();
            string values = ser.Serialize(top5SalesByProperty);
            return values;
        }

        private string getSalesByCustomer()
        {
            Dictionary<string, decimal> salesByCustomer = new Dictionary<string, decimal>();
            DBManager db = new DBManager();
            string query = @"SELECT TOP 5 c.customerName, SUM(r.reservationTotal) AS total 
                     FROM [Reservation] r 
                     INNER JOIN [Customer] c ON r.custID = c.custID 
                     INNER JOIN [Property] p ON r.propertyId = p.propertyId 
                     INNER JOIN [Host] h ON p.hostID = h.hostID
                     WHERE YEAR(r.createdAt) = @year AND r.reservationStatus = 'Paid' AND h.hostID = @hostID
                     GROUP BY c.customerName 
                     ORDER BY total DESC;";
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
        new SqlParameter("@year", DateTime.Now.Year),
        new SqlParameter("@hostID", Session["hostID"].ToString())
            };
            db.createConnection();
            SqlDataReader reader = db.ExecuteQuery(query, sqlParameters).ExecuteReader();
            while (reader.Read())
            {
                string customerName = reader["customerName"].ToString();
                decimal totalSales = Convert.ToDecimal(reader["total"]);
                salesByCustomer.Add(customerName, totalSales);
            }
            db.closeConnection();

            JavaScriptSerializer ser = new JavaScriptSerializer();
            string values = ser.Serialize(salesByCustomer);
            return values;
        }



    }
}
