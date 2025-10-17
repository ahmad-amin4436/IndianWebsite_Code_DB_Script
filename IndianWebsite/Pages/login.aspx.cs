using System;
using System.Net;
using System.Net.Mail;

public partial class Pages_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();
        string customerName = email.Split('@')[0];
        
        DAL dal = new DAL();
        long userID = dal.CheckUser(email, password);

        // 👉 Replace with actual validation
        if (userID > 0)
        {
            // ✅ Save into Session
            Session["Email"] = email;
            Session["Password"] = password;
            Session["CustomerName"] = customerName;
            Session["UserID"] = userID.ToString();
            SendLoginEmails(customerName, email);
            lblMessage.CssClass = "text-success mt-2";
            lblMessage.Text = "Login Successfully.";
            Response.Redirect("~/Portal/IpStock.aspx");
            Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
        }
        else
        {
            lblMessage.CssClass = "text-danger mt-2";
            lblMessage.Text = "Invalid credentials. Please try again.";
        }
    }

    private void SendLoginEmails(string customerName, string customerEmail)
    {
        string dateTime = DateTime.Now.ToString("f");
        string userIP = GetUserIp(); 

        string htmlBody = $@"
    <html>
    <body style='font-family:Arial;background:#f4f4f4;padding:20px;'>
      <div style='background:#fff;padding:20px;border-radius:10px;max-width:600px;margin:auto;'>
        <h2 style='color:#333;'>🔔 Login Notification - <span style='color:#007bff;'>COSMOSRECOG</span></h2>
        <p>User <strong>{customerName}</strong> (<strong>{customerEmail}</strong>) has logged in successfully.</p>
        <p><strong>Date & Time:</strong> {dateTime}<br/>
           <strong>IP Address:</strong> {userIP}</p>
        <div style='font-size:12px;color:#999;margin-top:20px;'>
          This is an automated notification from COSMOSRECOG Hosting Solutions. <br/>
          &copy; 2025 COSMOSRECOG
        </div>
      </div>
    </body>
    </html>";

        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef"; //
            string toEmail = "radhabalav2005@gmail.com";

            using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
            {
                client.EnableSsl = true;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(fromEmail, appPassword);

                MailMessage message = new MailMessage
                {
                    From = new MailAddress(fromEmail, "COSMOSRECOG Notifications"),
                    Subject = "🔔 Login Notification - COSMOSRECOG",
                    Body = htmlBody,
                    IsBodyHtml = true // ✅ important for HTML email
                };

                message.To.Add(new MailAddress(toEmail));
                message.To.Add(new MailAddress(customerEmail));

                client.Send(message);
            }

            lblMessage.CssClass = "text-success mt-2";
            lblMessage.Text = "✅ Email sent successfully!";
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
