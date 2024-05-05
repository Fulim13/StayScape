using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

namespace StayScape
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ////Only run this code when the page is loaded for the first time
            //if (!IsPostBack)
            //{

            //}
            // Get Session Property ID
            int propertyID = Convert.ToInt32(Session["PropertyID"]);


            Session["discountAmount"] = 0;

            //Get the property price from the  session property ID
            DBManager db = new DBManager();
            db.createConnection();
            string sqlCommand = "SELECT propertyName, propertyPrice FROM Property WHERE propertyID = @propertyID";
            SqlParameter[] parameters =
            {
                new SqlParameter("@propertyID", propertyID)
            };
            SqlCommand command = db.ExecuteQuery(sqlCommand, parameters);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            string propertyName = reader["propertyName"].ToString();
            decimal propertyPrice = Convert.ToDecimal(reader["propertyPrice"]);
            db.closeConnection();

            //Get the property Image from the  session property ID
            db.createConnection();
            sqlCommand = "SELECT propertyPicture FROM PropertyImage WHERE propertyID = @propertyID";
            SqlParameter[] parameters2 =
            {
                new SqlParameter("@propertyID", propertyID)
            };
            command = db.ExecuteQuery(sqlCommand, parameters2);
            reader = command.ExecuteReader();
            if (reader.Read())
            {
                byte[] imageData = (byte[])reader["propertyPicture"];
                string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                imgProperty.ImageUrl = "data:image/jpeg;base64," + base64String;
            }
            else
            {
                // Handle case where no image is found
                imgProperty.ImageUrl = "/Images/testing.jpg"; // Or any default image path
            }


            //Display in the label
            lblSubtotal.Text = "RM " + propertyPrice.ToString();
            lblDiscount.Text = "RM " + Session["discountAmount"].ToString();
            lblTotal.Text = "RM " + Convert.ToString(propertyPrice - Convert.ToDecimal(Session["discountAmount"]));

            //Session["CheckIn"] = DateTime.Now;
            //Session["CheckOut"] = DateTime.Now.AddDays(1);
            Session["reservationAmount"] = propertyPrice - Convert.ToDecimal(Session["discountAmount"]);

            lblPropertyName.Text = propertyName;
            lblPropertyPrice.Text = "RM " + propertyPrice.ToString();
            lblDate.Text = Session["CheckIn"].ToString() + " - <br/>" + Session["CheckOut"].ToString();
        }

        [WebMethod]
        public static decimal ApplyDiscount(string code)
        {

            //Check the voucher code is on database or not, if not return 0
            DBManager db = new DBManager();
            db.createConnection();
            string sqlCommand = "SELECT COUNT(*) FROM Voucher WHERE voucherCode = @voucherCode";
            SqlParameter[] parameters =
            {
                new SqlParameter("@voucherCode", code)
            };
            SqlCommand command = db.ExecuteQuery(sqlCommand, parameters);
            int count = Convert.ToInt32(command.ExecuteScalar());
            if (count == 0)
            {
                return 0;
            }

            //Get session property ID
            int propertyID = Convert.ToInt32(HttpContext.Current.Session["PropertyID"]);

            //Get the hostID from the propertyID
            db.createConnection();
            sqlCommand = "SELECT hostID FROM Property WHERE propertyID = @propertyID";
            SqlParameter[] parameters1 =
            {
                new SqlParameter("@propertyID", propertyID)
            };
            command = db.ExecuteQuery(sqlCommand, parameters1);
            SqlDataReader reader = command.ExecuteReader();
            reader.Read();
            int hostID = Convert.ToInt32(reader["hostID"]);



            //Get all the voucher code for this host
            db.createConnection();
            sqlCommand = "SELECT voucherID, voucherCode,totalVoucher,redeemLimitPerCustomer,startDate,expiredDate,activeStatus,discountType,minSpend,discountRate,discountPrice,capAt,propertyID FROM Voucher WHERE hostID = @hostID";
            SqlParameter[] parameters2 =
            {
                new SqlParameter("@hostID", hostID)
            };
            command = db.ExecuteQuery(sqlCommand, parameters2);
            reader = command.ExecuteReader();
            while (reader.Read())
            {
                int voucherID = Convert.ToInt32(reader["voucherID"]);
                string voucherCode = reader["voucherCode"].ToString();
                int totalVoucher = Convert.ToInt32(reader["totalVoucher"]);
                int redeemLimitPerCustomer = Convert.ToInt32(reader["redeemLimitPerCustomer"]);
                DateTime startDate = Convert.ToDateTime(reader["startDate"]);
                DateTime expiredDate = Convert.ToDateTime(reader["expiredDate"]);
                bool activeStatus = Convert.ToBoolean(reader["activeStatus"]);
                string discountType = reader["discountType"].ToString();
                decimal minSpend = Convert.ToInt32(reader["minSpend"]);
                decimal discountRate = 0;
                if (reader["discountRate"] != DBNull.Value)
                {
                    discountRate = Convert.ToDecimal(reader["discountRate"]);
                }
                decimal discountPrice = 0;
                if (reader["discountPrice"] != DBNull.Value)
                {
                    discountPrice = Convert.ToDecimal(reader["discountPrice"]);
                }
                decimal capAt = 0;
                if (reader["capAt"] != DBNull.Value)
                {
                    capAt = Convert.ToDecimal(reader["capAt"]);
                }
                int propertyIDVoucher = 0;
                if (reader["propertyID"] != DBNull.Value)
                {
                    propertyIDVoucher = Convert.ToInt32(reader["propertyID"]);
                }


                if (code == voucherCode)
                {
                    //the voucher is for this property or not
                    if (propertyIDVoucher != propertyID && propertyIDVoucher != 0)
                    {
                        return 0;
                    }


                    //Check if the voucher is still active
                    if (!activeStatus)
                    {
                        return 0;
                    }

                    //Check if the voucher is still valid
                    if (DateTime.Now < startDate || DateTime.Now > expiredDate)
                    {
                        return 0;
                    }

                    //Get customer ID from session
                    int customerID = 1;
                    //int customerID = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

                    //Check if the customer has already redeem the voucher
                    db.createConnection();
                    sqlCommand = "SELECT COUNT(*) FROM Redemption WHERE custID = @customerID AND voucherID = @voucherID AND redemptionStatus = 'Used'";
                    SqlParameter[] parameters3 =
                    {
                        new SqlParameter("@customerID", customerID),
                        new SqlParameter("@voucherID", voucherID)
                    };
                    command = db.ExecuteQuery(sqlCommand, parameters3);
                    count = Convert.ToInt32(command.ExecuteScalar());
                    if (count > redeemLimitPerCustomer)
                    {
                        return 0;
                    }

                    //Check the that this voucher has been redeemed how many time for the redemptionStatus Used and cannot exceed the total voucher
                    db.createConnection();
                    sqlCommand = "SELECT COUNT(*) FROM Redemption WHERE voucherID = @voucherID AND redemptionStatus = 'Used'";
                    SqlParameter[] parameters4 =
                    {
                        new SqlParameter("@voucherID", voucherID)
                    };
                    command = db.ExecuteQuery(sqlCommand, parameters4);
                    count = Convert.ToInt32(command.ExecuteScalar());
                    if (count > totalVoucher)
                    {
                        return 0;
                    }

                    //Check discount type
                    if (discountType == "Value Off")
                    {
                        if (Convert.ToDecimal(HttpContext.Current.Session["reservationAmount"]) < minSpend)
                        {
                            return 0;
                        }

                        // store the discount amount in session
                        HttpContext.Current.Session["discountAmount"] = discountPrice;

                        //insert redemption to database
                        db.createConnection();
                        sqlCommand = "INSERT INTO Redemption (custID, voucherID, redemptionDate, redemptionStatus) VALUES (@custID, @voucherID, @redemptionDate, @redemptionStatus)";
                        SqlParameter[] parameters5 =
                        {
                            new SqlParameter("@custID", customerID),
                            new SqlParameter("@voucherID", voucherID),
                            new SqlParameter("@redemptionDate", DateTime.Now),
                            new SqlParameter("@redemptionStatus", "Pending")
                        };
                        db.ExecuteNonQuery(sqlCommand, parameters5);

                        //store redemption ID in session
                        sqlCommand = "SELECT redemptionID FROM Redemption WHERE custID = @custID AND voucherID = @voucherID";
                        SqlParameter[] parameters6 =
                        {
                            new SqlParameter("@custID", customerID),
                            new SqlParameter("@voucherID", voucherID)
                        };
                        command = db.ExecuteQuery(sqlCommand, parameters6);
                        reader = command.ExecuteReader();
                        reader.Read();
                        int redemptionID = Convert.ToInt32(reader["redemptionID"]);
                        HttpContext.Current.Session["redemptionID"] = redemptionID;

                        return discountPrice;

                    }
                    else if (discountType == "Percentage Off")
                    {
                        if (Convert.ToDecimal(HttpContext.Current.Session["reservationAmount"]) < minSpend)
                        {
                            return 0;
                        }

                        decimal discountAmount = Convert.ToDecimal(HttpContext.Current.Session["reservationAmount"]) * discountRate / 100;
                        if (discountAmount > capAt)
                        {
                            discountAmount = capAt;
                        }
                        //store redemption ID in session
                        sqlCommand = "SELECT redemptionID FROM Redemption WHERE custID = @custID AND voucherID = @voucherID";
                        SqlParameter[] parameters6 =
                        {
                            new SqlParameter("@custID", customerID),
                            new SqlParameter("@voucherID", voucherID)
                        };
                        command = db.ExecuteQuery(sqlCommand, parameters6);
                        reader = command.ExecuteReader();
                        reader.Read();
                        int redemptionID = Convert.ToInt32(reader["redemptionID"]);
                        HttpContext.Current.Session["redemptionID"] = redemptionID;


                        // store the discount amount in session
                        HttpContext.Current.Session["discountAmount"] = discountAmount;
                        return discountAmount;
                    }
                    else
                    {
                        return 0;
                    }

                }
            }

            //// Get all the voucher code for this property


            //Debug.WriteLine(propertyID);
            //Debug.WriteLine(code);
            //// Add your server-side code for applying the discount here
            //// Calculate and return the discount amount
            //// For example:
            ////decimal discountAmount = CalculateDiscount(code);
            ////return discountAmount;
            return 0;
        }

        private static decimal CalculateDiscount(string code)
        {

            // Add your discount calculation logic here
            // For example:
            if (code == "CHEAPPRICE")
            {
                return 10; // Apply a discount of RM 10
            }
            else
            {
                return 0; // No discount applied
            }
        }
    }
}