using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

public partial class Pages_payment_detail : Page
{
    private readonly string baseUrl = "https://smartvps.online/api/oceansmart";
    private readonly string authKey = "Basic U0NCSEFJOmZmZ2d2Y2hnNzg4Nw=="; // Auth Key

    protected async void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string txnId = Request.QueryString["client_txn_id"];
            if (!string.IsNullOrEmpty(txnId))
                await LoadTransactionAsync(txnId);
            else
                ShowNoRecord("Missing or invalid transaction ID.");
        }
    }

    private async Task LoadTransactionAsync(string txnId)
    {
        try
        {
            DAL dal = new DAL();

            // 1️⃣ Update Payment Status in DB
            dal.UpdatePaymentStatus(txnId);

            // 2️⃣ Get Payment Order
            var row = dal.GetPaymentOrder(txnId);
            if (row == null)
            {
                ShowNoRecord("No order found for this transaction.");
                return;
            }

            // 3️⃣ Populate UI
            DisplayTransactionDetails(row);

            string itemID = Session["SelectedHostItem"]?.ToString();
            string host = Session["Host"]?.ToString();

            if (string.IsNullOrEmpty(itemID) || string.IsNullOrEmpty(host))
            {
                lblVpsStatus.Text = "❌ Missing session details for VPS order.";
               // return;
            }

            if (host == "Yes")
                await HandleHostDzireOrderAsync(itemID);
            else
                await HandleOceanSmartOrderAsync(itemID);
            
        }
        catch (Exception ex)
        {
            ShowNoRecord($"⚠️ Error: {ex.Message}");
        }
    }

    private void DisplayTransactionDetails(DataRow row)
    {
        lblClientTxnId.Text = row["ClientTxnId"].ToString();
        lblCustomer.Text = row["CustomerName"].ToString();
        lblEmail.Text = row["CustomerEmail"].ToString();
        lblMobile.Text = row["CustomerMobile"].ToString();
        lblAmount.Text = "₹ " + row["Amount"];
        lblStatus.Text = Convert.ToBoolean(row["PaymentStatus"]) ? "Success" : "Failed";
        lblDate.Text = Convert.ToDateTime(row["CreatedAt"]).ToString("dd-MMM-yyyy hh:mm tt");

        pnlTransaction.Visible = true;
        pnlNoRecord.Visible = false;
    }

    private void ShowNoRecord(string message)
    {
        pnlTransaction.Visible = false;
        pnlNoRecord.Visible = true;
    }

    #region VPS HANDLERS

    private async Task HandleHostDzireOrderAsync(string itemID)
    {
        try
        {
            string ram = Session["RAM"]?.ToString() ?? "4";
            string serverOS = ram == "4" ? "Ubuntu 22 64" : "Windows 2022 64";
            string apiUrl = "https://hostdzire.com/api/vps/";

            using (var client = new HttpClient())
            {
                var keyValues = new List<KeyValuePair<string, string>>
            {
                new KeyValuePair<string, string>("api_key", "xuqb583H4navsdqv6PDBUAM6VBVHTQS48w5agfthma4K8JTEVHRLQA7mjgwgqj8y"),
                new KeyValuePair<string, string>("inventory_key", itemID),
                new KeyValuePair<string, string>("quantity", "1"),
                new KeyValuePair<string, string>("action", "place_order"),
                new KeyValuePair<string, string>("os", serverOS),
                new KeyValuePair<string, string>("coupon", "if_you_have"),
                new KeyValuePair<string, string>("email", lblEmail.Text)
            };

                var content = new FormUrlEncodedContent(keyValues);
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");

                var response = await client.PostAsync(apiUrl, content);
                string responseText = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                {
                    lblVpsStatus.Text = $"❌ API Error {response.StatusCode}: {responseText}";
                    lblVpsDetails.Text = $"<pre>{Server.HtmlEncode(responseText)}</pre>";
                    return;
                }

                // ✅ Parse JSON safely
                JObject json = JObject.Parse(responseText);

                string status = json["status"]?.ToString();
                string message = json["message"]?.ToString();
                string orderId = json["order_id"]?.ToString();
                string ip = json["ips"]?.FirstOrDefault()?.ToString() ?? "N/A";

                lblVpsStatus.Text = status == "success"
                    ? "✅ VPS order placed successfully."
                    : $"⚠️ VPS order response: {message}";

                // ✅ Save in DB
                DAL dal = new DAL();
                dal.InsertVpsOrder(
                    lblClientTxnId.Text,
                    Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : (int?)null,
                    ip,                  // Actual IP from response
                    serverOS,
                    lblCustomer.Text,    // Username / Customer name
                    "",                  // Password (not provided)
                    status ?? "Pending", // Action status
                    "Running",           // Machine status
                    "Running",           // Power status
                    ram,
                    DateTime.Now.AddMonths(1)
                );
                
                // ✅ Display details on page
                lblVpsDetails.Text = $@"
                <b>Order ID:</b> {orderId}<br/>
                <b>IP:</b> {ip}<br/>
                <b>OS:</b> {serverOS}<br/>
                <b>Username:</b> {lblCustomer.Text}<br/>
                <b>RAM:</b> {ram}<br/>
                <b>Status:</b> {status}<br/>
                <b>Message:</b> {message}<br/>
                <b>Note:</b> VPS details have been sent to your registered email.";
                SendVpsDetailsEmail(
                   lblCustomer.Text,         // customer name
                   lblEmail.Text,            // customer email
                   "Cosmos Recog Server",              // provider name
                   ip,                       // VPS IP
                   serverOS,                 // OS
                   lblCustomer.Text,         // username
                   "Check your Manage Order at portal",       // password (if available)
                   ram,                      // RAM
                   status,                   // VPS status
                   DateTime.Now.AddMonths(1).ToString("f") // expiry
               );
            }
        }
        catch (HttpRequestException httpEx)
        {
            lblVpsStatus.Text = $"❌ HTTP Error: {httpEx.Message}";
        }
        catch (Exception ex)
        {
            lblVpsStatus.Text = $"❌ Error placing HostDzire VPS: {ex.Message}";
        }
    }


    private async Task HandleOceanSmartOrderAsync(string planId)
    {
    try
    {
        //string ram = Session["RAM"]?.ToString() ?? "4";
            string ip = Session["SelectedIpv4"].ToString();
            string ram = Session["SelectedRam"].ToString();
        var availableIP = await GetOneAvailableIpAsync(Session["SelectedPlanId"].ToString());
        if (availableIP == null)
        {
            lblVpsStatus.Text = "❌ No available IP found for VPS.";
            return;
        }

            var order = await BuyVpsAsync(availableIP.name, ram);

            // Clean up the response fields
            string Clean(string input)
            {
                if (string.IsNullOrWhiteSpace(input)) return string.Empty;
                return input.Replace("\\", "").Replace("\"", "").Trim();
            }

            string cleanStatus = Clean(order.Status);
            string assignedIp = Clean(order.IpAssigned);
            string cleanMessage = Clean(order.Message);

            // Display initial response
            lblVpsStatus.Text = $"{cleanStatus} - {cleanMessage}";

            // Only continue if success or IP assigned
            if (cleanStatus.Equals("success", StringComparison.OrdinalIgnoreCase) ||
                !string.IsNullOrEmpty(assignedIp))
            {
                // Get VPS status from API
                var status = await GetVpsStatusAsync(assignedIp, ram);

                // Display VPS status on screen
                DisplayVpsStatus(status);

                // Save VPS details in database
                DAL dal = new DAL();
                dal.InsertVpsOrder(
                    lblClientTxnId.Text,
                    Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : (int?)null,
                    status.IP?.Trim(),
                    status.OS?.Trim(),
                    status.Username?.Trim(),
                    status.Password?.Trim(),
                    status.ActionStatus?.Trim() ?? "Active",
                    status.MachineStatus?.Trim() ?? "Running",
                    status.PowerStatus?.Trim() ?? "Running",
                    status.RAM?.Trim() ?? ram,
                    status.ExpiryDate
                );
                lblVpsDetails.Text = $@"
                <b>Transaction ID:</b> {lblClientTxnId}<br/>
                <b>IP:</b> {ip}<br/>
                <b>OS:</b> {status.OS}<br/>
                <b>Username:</b> {lblCustomer.Text}<br/>
                <b>RAM:</b> {ram}<br/>
                <b>Status:</b> {status}<br/>
                <b>Note:</b> VPS details have been sent to your registered email.";
                SendVpsDetailsEmail(
                   lblCustomer.Text,         // customer name
                   lblEmail.Text,            // customer email
                   "Cosmos Recog Server",              // provider name
                   ip,                       // VPS IP
                   status.OS?.Trim(),                 // OS
                   lblCustomer.Text,         // username
                   "Check your Manage Order at portal",       // password (if available)
                   status.RAM,                      // RAM
                   status.PowerStatus?.Trim() ?? "Running",                   // VPS status
                   DateTime.Now.AddMonths(1).ToString("f") // expiry
               );
            }
            else
            {
                // Handle failure clearly
                lblVpsStatus.Text = $"❌ VPS Order Failed: {cleanMessage}";
            }

        }
        catch (Exception ex)
    {
        lblVpsStatus.Text = $"❌ Error ordering OceanSmart VPS: {ex.Message}";
    }
}
    private void SendVpsDetailsEmail(
    string customerName,
    string customerEmail,
    string providerName,
    string ip,
    string os,
    string username,
    string password,
    string ram,
    string status,
    string expiryDate)
    {
        string dateTime = DateTime.Now.ToString("f");

        string htmlBody = $@"
    <html>
    <body style='font-family:Arial;background:#f4f4f4;padding:20px;'>
      <div style='background:#fff;padding:20px;border-radius:10px;max-width:650px;margin:auto;'>
        <h2 style='color:#333;'>🖥️ VPS Order Confirmation - <span style='color:#007bff;'>{providerName}</span></h2>
        <p>Hi <strong>{customerName}</strong>,</p>
        <p>Your VPS has been successfully set up! Here are your details:</p>

        <table style='width:100%;border-collapse:collapse;margin-top:10px;'>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Provider</strong></td><td style='padding:8px;border:1px solid #ddd;'>{providerName}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>IP Address</strong></td><td style='padding:8px;border:1px solid #ddd;'>{ip}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>OS</strong></td><td style='padding:8px;border:1px solid #ddd;'>{os}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Username</strong></td><td style='padding:8px;border:1px solid #ddd;'>{username}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Password</strong></td><td style='padding:8px;border:1px solid #ddd;'>{password}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>RAM</strong></td><td style='padding:8px;border:1px solid #ddd;'>{ram} GB</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Status</strong></td><td style='padding:8px;border:1px solid #ddd;'>{status}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Expiry Date</strong></td><td style='padding:8px;border:1px solid #ddd;'>{expiryDate}</td></tr>
          <tr><td style='padding:8px;border:1px solid #ddd;'><strong>Generated On</strong></td><td style='padding:8px;border:1px solid #ddd;'>{dateTime}</td></tr>
        </table>

        <p style='margin-top:15px;'>Please keep this information safe. You can log in to your VPS using the above credentials.</p>

        <div style='font-size:12px;color:#999;margin-top:20px;'>
          This is an automated email from COSMOSRECOG Hosting Solutions.<br/>
          &copy; 2025 COSMOSRECOG
        </div>
      </div>
    </body>
    </html>";

        try
        {
            string fromEmail = "radhabalav2005@gmail.com";
            string appPassword = "btxc hvpi snjj knef";
            string sellerEmail = "radhabalav2005@gmail.com"; // seller/your team

            using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
            {
                client.EnableSsl = true;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(fromEmail, appPassword);

                MailMessage message = new MailMessage
                {
                    From = new MailAddress(fromEmail, "COSMOSRECOG VPS Team"),
                    Subject = $"✅ VPS Order Confirmation - {providerName}",
                    Body = htmlBody,
                    IsBodyHtml = true
                };

                message.To.Add(new MailAddress(customerEmail));
                message.To.Add(new MailAddress(sellerEmail));

                client.Send(message);
            }
        }
        catch (Exception ex)
        {
           
        }
    }


    string Clean(string input)
    {
        if (string.IsNullOrWhiteSpace(input)) return string.Empty;

        return input
            .Replace("\\", "")  // remove backslashes
            .Replace("\"", "")  // remove double quotes
            .Trim();            // remove extra spaces
    }

    private void DisplayVpsStatus(VpsStatusResponse status)
{
    lblVpsDetails.Text = $@"
            <b>IP:</b> {status.IP}<br/>
            <b>OS:</b> {status.OS}<br/>
            <b>Username:</b> {status.Username}<br/>
            <b>Password:</b> {status.Password}<br/>
            <b>Status:</b> {status.MachineStatus} ({status.PowerStatus})<br/>
            <b>RAM:</b> {status.RAM}<br/>
            <b>Expiry:</b> {status.ExpiryDate:dd-MMM-yyyy hh:mm tt}";
}

#endregion

        #region API METHODS

        public async Task<Package> GetOneAvailableIpAsync(string planId)
        {
            using (var client = new HttpClient())
            {
                var request = new HttpRequestMessage(HttpMethod.Post, $"{baseUrl}/ipstock");
                request.Headers.Add("Authorization", authKey);

                var response = await client.SendAsync(request);
                response.EnsureSuccessStatusCode();

                string json = await response.Content.ReadAsStringAsync();
                if (json.StartsWith("\"") && json.EndsWith("\""))
                    json = JsonConvert.DeserializeObject<string>(json);

                var result = JsonConvert.DeserializeObject<ApiResponse>(json);

                if (result?.status == 1 && result.packages != null && int.TryParse(planId, out int pid))
                    return result.packages.FirstOrDefault(p => p.id == pid && p.status == "active" && p.ipv4 > 0);

                return null;
            }
        }

        public async Task<BuyVpsResponse> BuyVpsAsync(string ip, string ram)
        {
            using (var client = new HttpClient())
            {
                var request = new HttpRequestMessage(HttpMethod.Post, $"{baseUrl}/buyvps");
                request.Headers.Add("Authorization", authKey);

                var body = new { ip, ram };
                string json = JsonConvert.SerializeObject(body);
                request.Content = new StringContent(json, Encoding.UTF8, "application/json");

                var response = await client.SendAsync(request);
                response.EnsureSuccessStatusCode();

                string result = await response.Content.ReadAsStringAsync();
                var parts = result.Split('|');

                return new BuyVpsResponse
                {
                    Status = parts.ElementAtOrDefault(0) ?? "error",
                    Message = parts.ElementAtOrDefault(1) ?? "No message returned",
                    IpAssigned = ExtractIp(parts.ElementAtOrDefault(1))
                };
            }
        }

        private string ExtractIp(string message)
        {
            if (string.IsNullOrEmpty(message)) return null;
            var keyword = "Your ip is:";
            int idx = message.IndexOf(keyword, StringComparison.OrdinalIgnoreCase);
            return idx >= 0 ? message.Substring(idx + keyword.Length).Trim() : null;
        }

        public async Task<VpsStatusResponse> GetVpsStatusAsync(string ip, string ram)
        {
            using (var client = new HttpClient())
            {
                var request = new HttpRequestMessage(HttpMethod.Post, $"{baseUrl}/status");
                request.Headers.Add("Authorization", authKey);

                var body = new { ip, ram };
                var json = JsonConvert.SerializeObject(body);
                request.Content = new StringContent(json, Encoding.UTF8, "application/json");

                var response = await client.SendAsync(request);
                response.EnsureSuccessStatusCode();

                string result = await response.Content.ReadAsStringAsync();
                if (result.StartsWith("\"") && result.EndsWith("\""))
                    result = JsonConvert.DeserializeObject<string>(result);

                return JsonConvert.DeserializeObject<VpsStatusResponse>(result);
            }
        }

        #endregion

        #region MODELS

        public class ApiResponse
        {
            public int status { get; set; }
            public string message { get; set; }
            public List<Package> packages { get; set; }
        }

        public class Package
        {
            public int id { get; set; }
            public string name { get; set; }
            public int ipv4 { get; set; }
            public string status { get; set; }
        }

        public class BuyVpsResponse
        {
            public string Status { get; set; }
            public string Message { get; set; }
            public string IpAssigned { get; set; }
        }

        public class VpsStatusResponse
        {
            public string IP { get; set; }
            public string OS { get; set; }
            [JsonProperty("Usernane")]
            public string Username { get; set; }
            public string Password { get; set; }
            public string ActionStatus { get; set; }
            public string MachineStatus { get; set; }
            public string PowerStatus { get; set; }
            public string RAM { get; set; }
            public DateTime ExpiryDate { get; set; }
        }

    #endregion
}
