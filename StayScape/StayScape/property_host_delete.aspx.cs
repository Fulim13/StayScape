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
                // Select all properties regardless of activation status
                SqlCommand cmd = new SqlCommand("SELECT propertyID, propertyName, isActive FROM Property ORDER BY isActive DESC, propertyName", con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlProperty.DataSource = reader;
                ddlProperty.DataTextField = "propertyName";
                ddlProperty.DataValueField = "propertyID";
                ddlProperty.DataBind();

                // Optionally, add a default list item at the beginning of the dropdown
                ddlProperty.Items.Insert(0, new ListItem("--Select Property--", ""));
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

            if (ddlProperty.SelectedIndex > 0)
            {
                ddlProperty.Items[0].Enabled = false;
                ddlProperty.Items.RemoveAt(0);
            }
        }

        private void ShowPropertyDetails(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT propertyPrice, propertyDesc, propertyAddress, isActive FROM Property WHERE propertyID = @propertyID", con);
                cmd.Parameters.AddWithValue("@propertyID", propertyID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblPrice.Text = reader["propertyPrice"].ToString();
                    lblDescription.Text = reader["propertyDesc"].ToString();
                    lblAddress.Text = reader["propertyAddress"].ToString();
                    bool isActive = Convert.ToBoolean(reader["isActive"]);
                    lblActiveStatus.Text = isActive ? "Status: Active" : "Status: Inactive";
                    lblActiveStatus.ForeColor = isActive ? System.Drawing.Color.Green : System.Drawing.Color.Red;
                    btnToggleActive.Text = isActive ? "Deactivate" : "Activate";
                }
            }
        }


        protected void btnToggleActive_Click(object sender, EventArgs e)
        {
            int propertyID = Convert.ToInt32(ddlProperty.SelectedValue);
            if (propertyID > 0)
            {
                TogglePropertyActivation(propertyID);
            }
        }

        private void TogglePropertyActivation(int propertyID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Property SET isActive = 1 - isActive WHERE propertyID = @propertyID", con);
                    cmd.Parameters.AddWithValue("@propertyID", propertyID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Property activation status updated successfully.');", true);
                    ShowPropertyDetails(propertyID); // Refresh the details including active status
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Failed to update property activation status. Error: " + ex.Message + "');", true);
            }
        }


        private void ClearFormFields()
        {
            // Clear all the input fields
            lblPrice.Text = string.Empty;
            lblDescription.Text = string.Empty;
            lblAddress.Text = string.Empty;
        }
    }
}