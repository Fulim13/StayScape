using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class property_host_delete : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateProperties();
            }
        }

        private void PopulateProperties()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT propertyID, propertyName FROM Property", con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlProperty.DataSource = reader;
                ddlProperty.DataTextField = "propertyName";
                ddlProperty.DataValueField = "propertyID";
                ddlProperty.DataBind();
            }
        }

        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            int propertyID = Convert.ToInt32(ddlProperty.SelectedValue);
            if (propertyID > 0)
            {
                ShowPropertyDetails(propertyID);
                PanelPropertyDetails.Visible = true;
            }
            else
            {
                PanelPropertyDetails.Visible = false;
            }
        }

        private void ShowPropertyDetails(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT propertyPrice, propertyDesc, propertyAddress FROM Property WHERE propertyID = @propertyID", con);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblPrice.Text = reader["propertyPrice"].ToString();
                    lblDescription.Text = reader["propertyDesc"].ToString();
                    lblAddress.Text = reader["propertyAddress"].ToString();
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int propertyID = Convert.ToInt32(ddlProperty.SelectedValue);
            if (propertyID > 0)
            {
                DeleteProperty(propertyID);
            }
        }

        private void DeleteProperty(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM PropertyImage WHERE propertyID = @propertyID; DELETE FROM Property WHERE propertyID = @propertyID;", con);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);
                con.Open();
                cmd.ExecuteNonQuery();
                lblSuccess.Text = "Property deleted successfully!";
                PopulateProperties(); // Refresh dropdown list after delete
                Response.Redirect(Request.RawUrl); // This will reload the page

            }
        }

    }
}