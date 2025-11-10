using System;
using System.Web.UI.WebControls;

public partial class Portal_assignserver : System.Web.UI.Page
{
    DAL dal = new DAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null || Convert.ToInt32(Session["UserID"]) != 19|| Session["Password"] == null || Session["CustomerName"] == null)
        {
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
            return;
        }

        if (!IsPostBack)  // ✅ Prevent rebind on postback (keeps selection)
        {
            ddlUserEmail.DataSource = dal.LoadUsers();
            ddlUserEmail.DataTextField = "Email";
            ddlUserEmail.DataValueField = "UserID";
            ddlUserEmail.DataBind();
            ddlUserEmail.Items.Insert(0, new ListItem("Select user...", ""));
        }
    }

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        try
        {
            // ✅ Handle blank dropdown safely
            if (string.IsNullOrEmpty(ddlUserEmail.SelectedValue))
            {
                lblResult.Text = "⚠️ Please select a user first.";
                lblResult.CssClass = "text-warning fw-bold";
                return;
            }

            int userId = Convert.ToInt32(ddlUserEmail.SelectedValue);

            DateTime expiryDate;
            DateTime.TryParse(txtExpiry.Text, out expiryDate);

            dal.InsertVpsOrder(
                "TXN" + DateTime.Now.ToString("yyyyMMddHHmmss"),
                userId,
                txtIP.Text.Trim(),
                txtOS.Text.Trim(),
                txtUsername.Text,
                txtPassword.Text.Trim(),
                "Active",
                "Running",
                "Running",
                txtMemory.Text.Trim(),
                expiryDate
            );

            lblResult.Text = "✅ Server assigned successfully!";
            lblResult.CssClass = "text-success fw-bold";

            // ✅ Clear inputs after success
            txtIP.Text = txtOS.Text = txtPassword.Text = txtMemory.Text = "";
            txtExpiry.Text = "";
            ddlUserEmail.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            lblResult.Text = "❌ Error assigning server. Please try again.";
            lblResult.CssClass = "text-danger fw-bold";
            System.Diagnostics.Debug.WriteLine("Error in btnAssign_Click: " + ex.Message);
        }
    }
}
