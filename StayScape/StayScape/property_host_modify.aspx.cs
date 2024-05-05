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
    public partial class property_host_modify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulatePropertyDropDown();
            }
        }

        private void PopulatePropertyDropDown()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT propertyID, propertyName FROM Property", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlProperty.DataSource = reader;
                ddlProperty.DataTextField = "propertyName";
                ddlProperty.DataValueField = "propertyID";
                ddlProperty.DataBind();
                ddlProperty.Items.Insert(0, new ListItem("--Select Property--", ""));
            }
        }

        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            int propertyID = Convert.ToInt32(ddlProperty.SelectedValue);
            if (propertyID != 0)
            {
                LoadPropertyDetails(propertyID);
            }
        }

        private void LoadPropertyDetails(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Property WHERE propertyID = @propertyID", conn);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtPropertyName.Text = reader["propertyName"].ToString();
                    txtPropertyPrice.Text = reader["propertyPrice"].ToString();
                    txtPropertyDesc.Text = reader["propertyDesc"].ToString();
                    txtPropertyAddress.Text = reader["propertyAddress"].ToString();
                    txtCity.Text = reader["propertyAddress_City"].ToString();
                    txtState.Text = reader["propertyAddress_State"].ToString();
                    txtTotalBedrooms.Text = reader["totalBedroom"].ToString();
                    txtTotalBathrooms.Text = reader["totalBathroom"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int propertyID = Convert.ToInt32(ddlProperty.SelectedValue);
            UpdatePropertyDetails(propertyID);
        }

        private void UpdatePropertyDetails(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Property SET propertyName = @propertyName, propertyPrice = @propertyPrice, propertyDesc = @propertyDesc, propertyAddress = @propertyAddress, propertyAddress_City = @city, propertyAddress_State = @state, totalBedroom = @totalBedroom, totalBathroom = @totalBathroom, lastUpdate = GETDATE() WHERE propertyID = @propertyID", conn);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);
                cmd.Parameters.AddWithValue("@propertyName", txtPropertyName.Text);
                cmd.Parameters.AddWithValue("@propertyPrice", decimal.Parse(txtPropertyPrice.Text));
                cmd.Parameters.AddWithValue("@propertyDesc", txtPropertyDesc.Text);
                cmd.Parameters.AddWithValue("@propertyAddress", txtPropertyAddress.Text);
                cmd.Parameters.AddWithValue("@city", txtCity.Text);
                cmd.Parameters.AddWithValue("@state", txtState.Text);
                cmd.Parameters.AddWithValue("@totalBedroom", int.Parse(txtTotalBedrooms.Text));
                cmd.Parameters.AddWithValue("@totalBathroom", int.Parse(txtTotalBathrooms.Text));
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Optionally show a success message or redirect
            Response.Write("<script>alert('Property updated successfully');</script>");
        }
    }
}