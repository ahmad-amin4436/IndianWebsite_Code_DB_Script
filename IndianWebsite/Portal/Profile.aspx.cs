using System;
using System.Data;

public partial class Portal_Profile : System.Web.UI.Page
{
    DAL dal = new DAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null || Session["Password"] == null || Session["CustomerName"] == null)
        {
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
            return;
        }
        if (!IsPostBack)
        {
            LoadProfile();
        }
    }

    private void LoadProfile()
    {
        if (Session["UserID"] != null)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            DataTable dt = dal.GetUserProfile(userId);

            if (dt.Rows.Count > 0)
            {
                lblFullName.Text = dt.Rows[0]["FullName"].ToString();
                lblEmail.Text = dt.Rows[0]["Email"].ToString();
                lblCreatedDate.Text = Convert.ToDateTime(dt.Rows[0]["CreatedDate"]).ToString("dd-MMM-yyyy");
            }
        }
    }

    protected void btnDeleteAccount_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            dal.DeleteUser(userId);

            Session.Clear();
            Response.Redirect("~/Pages/login.aspx");
        }
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (Session["UserID"] != null)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            bool success = dal.ChangePassword(
                userId,
                txtCurrentPassword.Text,
                txtNewPassword.Text
            );

            if (success)
            {
                lblMessage.CssClass = "text-success mt-2";
                lblMessage.Text = "Password changed successfully. Please log in again.";
                Session.Clear();
                Response.Redirect("~/Pages/login.aspx");
            }
            else
            {
                lblMessage.CssClass = "text-danger mt-2";
                lblMessage.Text = "Current password is incorrect.";
            }
        }
    }
}
