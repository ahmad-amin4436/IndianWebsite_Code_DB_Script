using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;

public partial class Pages_livechat : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnStartChat_Click(object sender, EventArgs e)
    {
        string email = txtUserEmail.Text.Trim();

        if (string.IsNullOrEmpty(email) || !email.Contains("@"))
        {
            lblEmailError.Text = "Please enter a valid email.";
            lblEmailError.Visible = true;
            return;
        }

        // ✅ Generate and send OTP
        string otp = new Random().Next(100000, 999999).ToString();
        Session["ChatEmail"] = email;
        Session["ChatOTP"] = otp;
        Session["ChatVerified"] = false;

        SendOTPEmail(email, otp);

        // Show OTP section
        emailSection.Visible = false;
        otpSection.Visible = true;
    }

    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        string enteredOtp = txtOTP.Text.Trim();
        string correctOtp = Session["ChatOTP"]?.ToString();
        string email = Session["ChatEmail"]?.ToString();

        if (enteredOtp == correctOtp)
        {
            NotifyAgentEmail(email);
            Session["ChatVerified"] = true;
            lblUserEmail.Text = email;
            otpSection.Visible = false;
            chatSection.Visible = true;

            // ✅ Load previous chat messages
            DAL dal = new DAL();
            List<ChatMessage> messagesList = dal.GetMessages(email);

            var messages = messagesList.Select(m => new
            {
                Sender = m.Sender,
                Message = m.Message,
                SentAt = m.SentAt.ToString("yyyy-MM-dd HH:mm:ss")
            }).ToList();

            string jsonMessages = Newtonsoft.Json.JsonConvert.SerializeObject(messages);
            ClientScript.RegisterStartupScript(this.GetType(), "loadChatHistory",
                $"var previousMessages = {jsonMessages};", true);
        }
        else
        {
            lblOTPError.Text = "Invalid OTP. Please try again.";
            lblOTPError.Visible = true;
        }
    }

    private void SendOTPEmail(string toEmail, string otp)
    {
        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef"; //
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.From = new MailAddress(fromEmail);
            mail.Subject = "Your Chat Verification Code";
            mail.Body = $"Your OTP for starting live chat is: {otp}";

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
            lblEmailError.Text = "Failed to send OTP: " + ex.Message;
            lblEmailError.Visible = true;
        }
    }
    private void NotifyAgentEmail(string customerEmail)
    {
        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef"; // Gmail App Password
            string toEmail = "radhabalav2005@gmail.com";  // 🔔 Replace with your agent/support email
            string link = "https://cosmosrecogserver.com/pages/supportdashboard";  // 🔔 Replace with your agent/support email

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromEmail, "CosmosRecog Live Chat");
            mail.To.Add(toEmail);
            mail.Subject = "🟢 New Customer Waiting for Support";
            mail.Body =
                $"Dear Support Team,\n\n" +
                $"A new customer has verified their email and is waiting for assistance.\n\n" +
                $"📧 Customer Email: {customerEmail}\n" +
                $"🕒 Joined At: {DateTime.Now:yyyy-MM-dd HH:mm:ss}\n\n" +
                $"Please join the live chat dashboard to assist them.\n\n" +
                $"— CosmosRecog Chat System : {link}";

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
            // You can log the error if needed
            lblOTPError.Text = "Failed to notify support: " + ex.Message;
            lblOTPError.Visible = true;
        }
    }

}
