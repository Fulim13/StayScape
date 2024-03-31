using System;
using System.Data.SqlClient;

namespace StayScape
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Store Property ID to Session
            //Session["PropertyID"] = 1;

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
    }
}