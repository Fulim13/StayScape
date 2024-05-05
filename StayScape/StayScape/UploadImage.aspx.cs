using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class UploadImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                // Check if the uploaded file is an image by checking its MIME type (optional)
                if (fileUpload.PostedFile.ContentType.ToLower().StartsWith("image/"))
                {
                    int propertyId = 7;  // Example property ID, you might get it from another part of your form
                    byte[] imageData = null;

                    using (var binaryReader = new BinaryReader(fileUpload.PostedFile.InputStream))
                    {
                        imageData = binaryReader.ReadBytes(fileUpload.PostedFile.ContentLength);
                    }

                    string connectionString = ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string sqlQuery = "INSERT INTO PropertyImage (propertyPicture, propertyID) VALUES (@Image, @PropertyID)";
                        using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                        {
                            command.Parameters.AddWithValue("@Image", imageData);
                            command.Parameters.AddWithValue("@PropertyID", propertyId);

                            connection.Open();
                            int result = command.ExecuteNonQuery();
                            connection.Close();

                            if (result > 0)
                            {
                                Response.Write("Image uploaded successfully!");
                            }
                            else
                            {
                                Response.Write("Image not uploaded!");
                            }
                        }
                    }
                }
                else
                {
                    Response.Write("Please upload an image file.");
                }
            }
            else
            {
                Response.Write("Please choose an image file to upload.");
            }
        }
    }
}