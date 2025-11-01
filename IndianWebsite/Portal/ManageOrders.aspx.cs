using System;
using System.Data;
using System.Web;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using System.Web.UI.WebControls;
using System.Linq;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

public partial class Portal_ManageOrders : System.Web.UI.Page
{
    DAL orderDal = new DAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadOrders();
        }
    }

    private async void LoadOrders()
    {
        int userId = Convert.ToInt32(Session["UserID"]);
        string search = txtSearch.Text.Trim();
        DataTable dtOrders = new DataTable();
        if (userId == 19)
        {
             dtOrders = orderDal.GetOrdersForAdmin(userId, search);

        }
        else
        {
             dtOrders = orderDal.GetOrders(userId, search);

        }
        // Step 1: Fetch orders from DB

        // Step 2: Prepare DataTable for merged API results
        DataTable dtApiResults = new DataTable();
        dtApiResults.Columns.Add("IP");
        dtApiResults.Columns.Add("OS");
        dtApiResults.Columns.Add("Username");
        dtApiResults.Columns.Add("Password");
        dtApiResults.Columns.Add("ActionStatus");
        dtApiResults.Columns.Add("MachineStatus");
        dtApiResults.Columns.Add("PowerStatus");
        dtApiResults.Columns.Add("RAM");
        dtApiResults.Columns.Add("ExpiryDate");
        dtApiResults.Columns.Add("CustomerName");
        dtApiResults.Columns.Add("Email");


        using (HttpClient client = new HttpClient())
        {
            client.DefaultRequestHeaders.Add("Authorization", "Basic U0NCSEFJOmZmZ2d2Y2hnNzg4Nw==");

            foreach (DataRow row in dtOrders.Rows)
            {
                var payload = new { ip = row["IP"].ToString() };
                string CustomerName = Session["CustomerName"].ToString();
                string Email = "";
                if (userId == 19)
                {
                    CustomerName = row["CustomerName"].ToString();
                    Email = row["Email"].ToString();
                }
                StringContent content = new StringContent(JsonConvert.SerializeObject(payload), Encoding.UTF8, "application/json");
                HttpResponseMessage response = await client.PostAsync("https://smartvps.online/api/oceansmart/status", content);

                if (response.IsSuccessStatusCode)
                {
                    string jsonString = await response.Content.ReadAsStringAsync();
                    string cleanJson = jsonString.Trim('"').Replace("\\\"", "\"");

                    // Skip if response is just "error"
                    if (cleanJson.Equals("error", StringComparison.OrdinalIgnoreCase))
                    {
                        
                            string apiUrl = "https://hostdzire.com/api/vps/";
                            string apiKey = "xuqb583H4navsdqv6PDBUAM6VBVHTQS48w5agfthma4K8JTEVHRLQA7mjgwgqj8y";

                            using (var httpClient = new HttpClient())
                            {
                                // Prepare the form data
                                var keyValues = new List<KeyValuePair<string, string>>
                        {
                            new KeyValuePair<string, string>("api_key", apiKey),
                            new KeyValuePair<string, string>("ip", row["IP"].ToString()),
                            new KeyValuePair<string, string>("action", "details")
                        };

                                var contentHD = new FormUrlEncodedContent(keyValues);
                                contentHD.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");

                                // Send the POST request
                                var responseHD = await httpClient.PostAsync(apiUrl, contentHD);

                                // Read response
                                string responseText = await responseHD.Content.ReadAsStringAsync();

                                // (Optional) Check success
                                if (responseHD.IsSuccessStatusCode)
                                {
                                    string json= await responseHD.Content.ReadAsStringAsync();
                                    string cleanjson = json.Trim('"').Replace("\\\"", "\"");

                                    // Skip if response is just "error"
                                    if (cleanjson.Equals("error", StringComparison.OrdinalIgnoreCase))
                                    {
                                        continue; // skip this IP
                                    }

                                var apiResponse = JsonConvert.DeserializeObject<HostDzireApiResponse>(cleanjson);

                                if (apiResponse != null && apiResponse.status == "success" && apiResponse.data != null)
                                {
                                    // ✅ Extract IPv4 safely
                                    string ipv4 = apiResponse.data.ipv4 ?? string.Empty;

                                    // ✅ Store in session only if not null/empty
                                    if (!string.IsNullOrEmpty(ipv4))
                                        Session["HostDzire"] = ipv4;

                                    // ✅ Also store ON/OFF status
                                    Session["HD_ON_or_OFF"] = apiResponse.data.lastActionMethod ?? string.Empty;

                                    // ✅ Add data to DataTable
                                    string osName = apiResponse.data.os ?? "";
                                    string userName = osName.ToLower().Contains("windows") ? "Administrator" : "root";

                                    dtApiResults.Rows.Add(
                                        ipv4,
                                        osName,
                                        userName,
                                        apiResponse.data.password ?? "",
                                        apiResponse.data.lastActionStatus ?? "",
                                        apiResponse.data.lastActionMethod ?? "",
                                        apiResponse.data.status ?? "",
                                        $"{apiResponse.data.memorySize} MB",
                                        "", // expiry date placeholder
                                        CustomerName,
                                        Email
                                    );
                                }
                                


                            }

                            else
                                {
                                    Console.WriteLine($"Failed ({(int)responseHD.StatusCode}): {responseText}");
                                }
                            }


                        
                        continue; // skip this IP
                    }

                    var apiData = JsonConvert.DeserializeObject<ApiResponse>(cleanJson);

                    dtApiResults.Rows.Add(
                        apiData.IP,
                        apiData.OS,
                        apiData.Usernane, // API typo preserved
                        apiData.Password,
                        apiData.ActionStatus,
                        apiData.MachineStatus,
                        apiData.PowerStatus,
                        apiData.RAM,
                        apiData.ExpiryDate,
                        CustomerName,
                        Email
                    );
                }
                
            }
        }

        rptOrders.DataSource = dtApiResults.Rows.Count > 0 ? dtApiResults : null;
        rptOrders.DataBind();
        pnlNoOrders.Visible = dtApiResults.Rows.Count == 0;
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        LoadOrders();
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        LoadOrders();
    }

    protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string ip = e.CommandArgument.ToString();

        switch (e.CommandName)
        {
            case "StartStop":
                bool isRunning = (e.CommandSource as Button).Text == "Stop";
                TogglePower(ip, isRunning);
                break;

            case "Format":
                FormatServer(ip);
                break;
        }

        LoadOrders(); // Refresh UI
    }

    protected void ddlChangeOS_SelectedIndexChanged(object sender, EventArgs e)
    {
        var ddl = (DropDownList)sender;
        var item = (RepeaterItem)ddl.NamingContainer;
        var hfIP = (HiddenField)item.FindControl("hfIP");

        string ip = hfIP.Value;
        string selectedOS = ddl.SelectedValue;

        if (!string.IsNullOrEmpty(selectedOS))
        {
            ChangeOS(ip, selectedOS);
            LoadOrders();
        }

    }

    protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var ddl = (DropDownList)e.Item.FindControl("ddlChangeOS");
            var hfOS = (HiddenField)e.Item.FindControl("hfOS");
            var hfRAM = (HiddenField)e.Item.FindControl("hfRAM");

            if (ddl == null || hfOS == null || hfRAM == null)
                return;

            ddl.Items.Clear();

            string currentOS = hfOS.Value.ToLower();
            string currentRAM = hfRAM.Value.ToLower();
            string hostDzireIP = Session["HostDzire"] as string;

            bool isHostDzire = !string.IsNullOrWhiteSpace(hostDzireIP);

           
                if (currentOS.Contains("windows"))
                {
                    ddl.Items.Add(new ListItem("CentOS", "centos"));
                    ddl.Items.Add(new ListItem("Ubuntu", "ubuntu"));
                    ddl.Items.Add(new ListItem("Windows 2012", "2012"));
                    ddl.Items.Add(new ListItem("Windows 2016", "2016"));
                    ddl.Items.Add(new ListItem("Windows 2019", "2019"));
                    ddl.Items.Add(new ListItem("Windows 2022", "2022"));
                    ddl.Items.Add(new ListItem("Windows 11", "11"));
                }
                else if (currentOS.Contains("ubuntu") || currentOS.Contains("centos") || currentOS.Contains("linux"))
                {
                    if (currentRAM.Contains("4"))
                    {
                        ddl.Items.Add(new ListItem("CentOS", "centos"));
                        ddl.Items.Add(new ListItem("Ubuntu", "ubuntu"));
                    }
                    else
                    {
                        ddl.Items.Add(new ListItem("CentOS", "centos"));
                        ddl.Items.Add(new ListItem("Ubuntu", "ubuntu"));
                        ddl.Items.Add(new ListItem("Windows 2012", "2012"));
                        ddl.Items.Add(new ListItem("Windows 2016", "2016"));
                        ddl.Items.Add(new ListItem("Windows 2019", "2019"));
                        ddl.Items.Add(new ListItem("Windows 2022", "2022"));
                        ddl.Items.Add(new ListItem("Windows 11", "11"));
                    }
                }
            

            // ✅ Default placeholder at top
            ddl.Items.Insert(0, new ListItem("Change OS...", ""));
        }
    }

    private void TogglePower(string ip, bool isRunning)
    {
        string url = isRunning
            ? "https://smartvps.online/api/oceansmart/stop"
            : "https://smartvps.online/api/oceansmart/start";

        CallApi(url, new { ip = ip });
    }

    private void FormatServer(string ip) =>
        CallApi("https://smartvps.online/api/oceansmart/format", new { ip = ip });

    private void ChangeOS(string ip, string os) =>
        CallApi("https://smartvps.online/api/oceansmart/changeos", new { ip = ip, os = os });

    private void CallApi(string url, object payload)
    {
        using (var client = new HttpClient())
        {
            client.DefaultRequestHeaders.Clear();
            client.DefaultRequestHeaders.Add("Authorization", "Basic U0NCSEFJOmZmZ2d2Y2hnNzg4Nw==");

            var json = JsonConvert.SerializeObject(payload);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            try
            {
                var response = client.PostAsync(url, content).Result;
                var result = response.Content.ReadAsStringAsync().Result;

                if (response.IsSuccessStatusCode && !string.IsNullOrEmpty(result) && !result.ToLower().Contains("error"))
                {
                    // ✅ API success
                    ShowAlert("Action completed successfully!");
                }
                else
                {
                    var jsonIP = JObject.FromObject(payload);
                    string ip = jsonIP["ip"]?.ToString();
                    if (url == "https://smartvps.online/api/oceansmart/stop")
                    {
                        CallHostDzire("https://hostdzire.com/api/vps/", ip, "stop");
                    }
                    else if (url == "https://smartvps.online/api/oceansmart/start")
                    {
                        CallHostDzire("https://hostdzire.com/api/vps/", ip, "start");

                    }
                    else if (url == "https://smartvps.online/api/oceansmart/format")
                    {
                        CallHostDzire("https://hostdzire.com/api/vps/", ip, "reinstall");

                    }
                    else if (url == "https://smartvps.online/api/oceansmart/changeos")
                    {
                        string os = jsonIP["os"]?.ToString();
                        string osCode = string.Empty;

                        if (os.Contains("2012"))
                        {
                            osCode = "windows_2012_64";
                        }
                        else if (os.Contains("2016"))
                        {
                            osCode = "windows_2016_64";
                        }
                        else if (os.Contains("2019"))
                        {
                            osCode = "windows_2019_64";
                        }
                        else if (os.Contains("2022"))
                        {
                            osCode = "windows_2022_64";
                        }
                        else if (os.Contains("windows 11")||os.Contains("11") || os.Contains("win11") || os.Contains("windows11"))
                        {
                            osCode = "windows11_64";
                        }
                        else if (os.Contains("windows 10") || os.Contains("10") || os.Contains("win10") || os.Contains("windows10"))
                        {
                            osCode = "windows10_64";
                        }
                        else if (os.Contains("ubuntu"))
                        {
                            osCode = "ubuntu_22_64";
                        }
                        else if (os.Contains("centos"))
                        {
                            osCode = "centos_7_64";
                        }
                        else
                        {
                            osCode = os; // fallback if nothing matches
                        }

                        FormatHostDzireInstall("https://hostdzire.com/api/vps/", ip, "install", osCode);
                    }
                    else
                    {
                        // ❌ API error
                        ShowAlert("Error: Please try again later.");
                    }
                }
            }
            catch (Exception ex)
            {
                // ❌ Network or exception error
                ShowAlert("Something went wrong. Try again later.");
            }
        }
    }
    public async void CallHostDzire(string url, string ip,string action)
    {
        using (var httpClient = new HttpClient())
        {
            // Prepare the form data
            var keyValues = new List<KeyValuePair<string, string>>
                        {
                            new KeyValuePair<string, string>("api_key", "xuqb583H4navsdqv6PDBUAM6VBVHTQS48w5agfthma4K8JTEVHRLQA7mjgwgqj8y"),
                            new KeyValuePair<string, string>("ip", ip),
                            new KeyValuePair<string, string>("action", action)
                        };

            var contentHD = new FormUrlEncodedContent(keyValues);
            contentHD.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");

            // Send the POST request
            var responseHD = await httpClient.PostAsync(url, contentHD);

            // Read response
            string responseText = await responseHD.Content.ReadAsStringAsync();

            // (Optional) Check success
            if (responseHD.IsSuccessStatusCode)
            {
                ShowAlert("Action completed successfully!");
            }
        }
    }
    public async void FormatHostDzireInstall(string url, string ip, string action, string os)
    {
        using (var httpClient = new HttpClient())
        {
            // Prepare the form data
            var keyValues = new List<KeyValuePair<string, string>>
                        {
                            new KeyValuePair<string, string>("api_key", "xuqb583H4navsdqv6PDBUAM6VBVHTQS48w5agfthma4K8JTEVHRLQA7mjgwgqj8y"),
                            new KeyValuePair<string, string>("ip", ip),
                            new KeyValuePair<string, string>("action", action),
                            new KeyValuePair<string, string>("os", os)
                        };

            var contentHD = new FormUrlEncodedContent(keyValues);
            contentHD.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/x-www-form-urlencoded");

            // Send the POST request
            var responseHD = await httpClient.PostAsync(url, contentHD);

            // Read response
            string responseText = await responseHD.Content.ReadAsStringAsync();

            // (Optional) Check success
            if (responseHD.IsSuccessStatusCode)
            {
                ShowAlert("Action completed successfully!");
            }
        }
    }

    private void ShowAlert(string message, bool isSuccess = true)
    {
        lblMessage.Visible = true;
        lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        lblMessage.Text = message;
    }


    public class HostDzireApiResponse
    {
        public string status { get; set; }
        public HostDzireData data { get; set; }
    }

    public class HostDzireData
    {
        public string memoryUsage { get; set; }
        public string diskUsage { get; set; }
        public string cpuUsage { get; set; }
        public string uptime { get; set; }
        public string status { get; set; }
        public string password { get; set; }
        public int memorySize { get; set; }
        public int diskSize { get; set; }
        public int cpuCore { get; set; }
        public string hostname { get; set; }
        public string os { get; set; }
        public string ipv4 { get; set; }
        public string ipv6 { get; set; }
        public string price { get; set; }
        public string lastActionMethod { get; set; }
        public string lastActionStatus { get; set; }
    }

    // API Response model
    public class ApiResponse
    {
        public string IP { get; set; }
        public string OS { get; set; }
        public string Usernane { get; set; } // API typo
        public string Password { get; set; }
        public string ActionStatus { get; set; }
        public string MachineStatus { get; set; }
        public string PowerStatus { get; set; }
        public string RAM { get; set; }
        public string ExpiryDate { get; set; }
    }
}
