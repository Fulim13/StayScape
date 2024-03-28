using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StayScape
{
    public partial class VoucherDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["voucher_id"] == null)
            {
                //Panel1.Visible = false;
            }
            else
            {
                if (!IsPostBack)
                {
                    //fetchData();
                }
            }
        }
    }
}