using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_supportdashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null || Convert.ToInt32(Session["UserID"]) != 19 || Session["Password"] == null || Session["CustomerName"] == null)
        {
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
            return;
        }
    }
}