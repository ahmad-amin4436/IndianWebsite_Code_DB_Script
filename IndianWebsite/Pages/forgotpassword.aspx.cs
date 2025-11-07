using System;
using System.Data;
using System.Net.Mail;

public partial class Pages_forgotpassword : System.Web.UI.Page
{
    DAL dal = new DAL();

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btnSendOtp_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        DataTable dt = dal.GetUserByEmail(email);
        // Check if user exists (replace this with your DB logic)
        if (dt != null && dt.Rows.Count > 0)
        {
            // Generate OTP
            Random rnd = new Random();
            int otp = rnd.Next(100000, 999999);
            Session["OTP"] = otp;
            Session["Email"] = email;
            Session["UserID"] = dt.Rows[0]["UserID"].ToString();

            // Send OTP (You can replace with actual email logic)
            SendEmail(email, "Your OTP Code", $"Your OTP code is: {otp}");

            lblMessage.Text = "OTP sent to your email.";
            otpSection.Visible = true;
            emailSection.Visible = false;
        }
        else
        {
            lblMessage.Text = "Email not found.";
        }
    }

    protected void btnVerifyOtp_Click(object sender, EventArgs e)
    {
        string enteredOtp = txtOtp.Text.Trim();
        string sessionOtp = Session["OTP"]?.ToString();

        if (enteredOtp == sessionOtp)
        {
            lblMessage.Text = "OTP verified successfully.";
            otpSection.Visible = false;
            passwordSection.Visible = true;
        }
        else
        {
            lblMessage.Text = "Invalid OTP. Try again.";
        }
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        string newPass = txtNewPassword.Text.Trim();
        string confirmPass = txtConfirmPassword.Text.Trim();

        if (newPass != confirmPass)
        {
            lblMessage.Text = "Passwords do not match.";
            return;
        }

        string email = Session["Email"]?.ToString();

        if (!string.IsNullOrEmpty(email))
        {
            // TODO: Update password in DB
            dal.ChangePassword(Convert.ToInt32(Session["UserID"]), newPass, newPass);
            lblMessage.CssClass = "text-success";
            lblMessage.Text = "Password changed successfully. Redirecting to login...";

            // Clear OTP
            Session.Remove("OTP");
            Session.Remove("Email");

            // Redirect after delay
            Response.AddHeader("REFRESH", "3;URL=Login.aspx");
        }
        else
        {
            lblMessage.Text = "Session expired. Please try again.";
        }
    }

    private void SendEmail(string to, string subject, string body)
    {
        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef"; //
            MailMessage mail = new MailMessage();
            mail.To.Add(to);
            mail.From = new MailAddress(fromEmail);
            mail.Subject = subject;
            mail.Body = body;

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                Credentials = new System.Net.NetworkCredential(fromEmail, appPassword),
                EnableSsl = true
            };

            smtp.Send(mail);
        }
        catch (Exception ex)
        {
           
        }
    }
}
