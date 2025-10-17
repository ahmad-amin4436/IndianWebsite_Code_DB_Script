using System;
using System.Net;
using System.Net.Mail;

public partial class Pages_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();
        string confirmPassword = txtConfirmPassword.Text.Trim();

        if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) ||
            string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
        {
            lblMessage.CssClass = "text-danger mt-2";
            lblMessage.Text = "❌ All fields are required.";
            return;
        }

        if (password != confirmPassword)
        {
            lblMessage.CssClass = "text-danger mt-2";
            lblMessage.Text = "❌ Passwords do not match.";
            return;
        }

        // 👉 Save user to DB here (optional)

        SendWelcomeEmail(name, email, password);
        DAL dal = new DAL();
        dal.SaveUserData(name, email, password, password);
        lblMessage.CssClass = "text-success mt-2";
        lblMessage.Text = "✅ Account created successfully! A welcome email has been sent.";
    }


    private void SendWelcomeEmail(string customerName, string customerEmail, string password)
    {
        string dateTime = DateTime.Now.ToString("f");
        string userIP = GetUserIp();

        string htmlBody = $@"
    <html>
    <body style='font-family:Arial;background:#f4f4f4;padding:20px;'>
      <div style='background:#fff;padding:20px;border-radius:10px;max-width:600px;margin:auto;'>
        <h2 style='color:#333;'>🎉 Welcome to <span style='color:#007bff;'>COSMOSRECOG</span></h2>
        <p>Hi <strong>{customerName}</strong>,</p>
        <p>Your account has been successfully created with the following details:</p>

        <table style='width:100%;border-collapse:collapse;margin-top:10px;'>
          <tr>
            <td style='padding:8px;border:1px solid #ddd;'><strong>Full Name</strong></td>
            <td style='padding:8px;border:1px solid #ddd;'>{customerName}</td>
          </tr>
          <tr>
            <td style='padding:8px;border:1px solid #ddd;'><strong>Email</strong></td>
            <td style='padding:8px;border:1px solid #ddd;'>{customerEmail}</td>
          </tr>
          <tr>
            <td style='padding:8px;border:1px solid #ddd;'><strong>Password</strong></td>
            <td style='padding:8px;border:1px solid #ddd;'>{password}</td>
          </tr>
          <tr>
            <td style='padding:8px;border:1px solid #ddd;'><strong>IP Address</strong></td>
            <td style='padding:8px;border:1px solid #ddd;'>{userIP}</td>
          </tr>
          <tr>
            <td style='padding:8px;border:1px solid #ddd;'><strong>Date & Time</strong></td>
            <td style='padding:8px;border:1px solid #ddd;'>{dateTime}</td>
          </tr>
        </table>

        <p style='margin-top:15px;'>We’re excited to have you on board 🚀.</p>

        <div style='font-size:12px;color:#999;margin-top:20px;'>
          This is an automated welcome email from COSMOSRECOG Hosting Solutions. <br/>
          &copy; 2025 COSMOSRECOG
        </div>
      </div>
    </body>
    </html>";

        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef"; // Gmail App Password
            string toEmail = "radhabalav2005@gmail.com";


            using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
            {
                client.EnableSsl = true;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(fromEmail, appPassword);

                MailMessage message = new MailMessage
                {
                    From = new MailAddress(fromEmail, "COSMOSRECOG Team"),
                    Subject = "🎉 Welcome to COSMOSRECOG",
                    Body = htmlBody,
                    IsBodyHtml = true
                };

                message.To.Add(new MailAddress(customerEmail));
                message.To.Add(new MailAddress(toEmail));

                client.Send(message);
            }
        }
        catch (Exception ex)
        {
            lblMessage.CssClass = "text-danger mt-2";
            lblMessage.Text = "❌ Email sending failed: " + ex.Message;
        }
    }
    private string GetUserIp()
    {
        string ip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (!string.IsNullOrEmpty(ip))
        {
            // Can contain multiple IPs (proxy chain), take the first one
            string[] ipRange = ip.Split(',');
            if (ipRange.Length > 0)
            {
                return ipRange[0].Trim();
            }
        }

        // Fallback
        return Request.ServerVariables["REMOTE_ADDR"] ?? Request.UserHostAddress;
    }
}
