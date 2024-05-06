using dotenv.net;
using System;
using System.IO;
using System.Web.Security;

namespace StayScape
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {


            string envFilePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, ".env");

            if (File.Exists(envFilePath))
            {
                DotEnv.Load(options: new DotEnvOptions(envFilePaths: new[] { envFilePath }));
            }
            else
            {
                Console.WriteLine(".env file not found.");
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // Get the requested URL
            string requestedUrl = Request.Url.AbsolutePath.ToLower();

            if (requestedUrl.Contains("/home.aspx"))
            {
                Response.Redirect("~/Dashboard.aspx", true);
            }
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}