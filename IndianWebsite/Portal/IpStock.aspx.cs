using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;                  // HttpRuntime.Cache
using System.Web.Caching;         // Cache.NoSlidingExpiration
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Portal_IpStock : System.Web.UI.Page
{
    // Shared HttpClient (best practice)
    private static readonly HttpClient _httpClient = new HttpClient();
    private readonly string baseUrl = "https://smartvps.online/api/oceansmart";
    private readonly string authKey = "Basic U0NCSEFJOmZmZ2d2Y2hnNzg4Nw=="; // API Key (keep safe)

    protected async void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null || Session["Password"] == null || Session["CustomerName"] == null)
        {
            Response.Redirect("~/Default.aspx", false);
            Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
            return;
        }

        if (!IsPostBack)
        {
            // Load HostDzire offers first (cached) then bind IP plans (also cached)
            await BindHostDzireAsync();
            await BindIpPlans();
        }
    }

    // ---------------------------
    // HostDzire integration + caching
    // ---------------------------
    private async Task BindHostDzireAsync()
    {
        try
        {
            var offers = await GetHostDzireOffersAsync();

            if (offers == null || !offers.Any())
            {
                rptHostDzire.DataSource = null;
                rptHostDzire.DataBind();
                pnlNoHostDzire.Visible = true;
                return;
            }

            pnlNoHostDzire.Visible = false;
            rptHostDzire.DataSource = offers;
            rptHostDzire.DataBind();
        }
        catch (Exception ex)
        {
            // Optionally log
            pnlNoHostDzire.Visible = true;
        }
    }

    public async Task<List<HostOffer>> GetHostDzireOffersAsync()
    {
        string cacheKey = "HostDzireOffers";

        // Optional caching (uncomment if needed)
        // if (HttpRuntime.Cache[cacheKey] != null)
        //     return (List<HostOffer>)HttpRuntime.Cache[cacheKey];

        var result = new List<HostOffer>();

        try
        {
            // 🔹 Build form data for HostDzire API
            var formFields = new List<KeyValuePair<string, string>>
        {
            new KeyValuePair<string, string>("api_key", "xuqb583H4navsdqv6PDBUAM6VBVHTQS48w5agfthma4K8JTEVHRLQA7mjgwgqj8y"),
            new KeyValuePair<string, string>("action", "available_cloud_vps_data")
        };
            var content = new FormUrlEncodedContent(formFields);

            using (var req = new HttpRequestMessage(HttpMethod.Post, "https://hostdzire.com/api/vps/"))
            {
                req.Content = content;

                var resp = await _httpClient.SendAsync(req).ConfigureAwait(false);
                if (!resp.IsSuccessStatusCode)
                    return result;

                var json = await resp.Content.ReadAsStringAsync().ConfigureAwait(false);
                var root = JObject.Parse(json);
                var data = root["data"] as JObject;
                if (data == null) return result;

                foreach (var prop in data.Properties())
                {
                    try
                    {
                        string itemName = prop.Name;
                        var item = (JObject)prop.Value;

                        string ip = item.Value<string>("ip") ?? "";
                        int vps = item.Value<int?>("vps") ?? 0;
                        int qty = item.Value<int?>("qty") ?? 0;
                        string pid = item.Value<string>("pid") ?? item.Value<int?>("pid")?.ToString() ?? "";

                        // 🔹 Detect RAM from item name (fallback to VPS value)
                        int ram = 0;
                        string lowerName = itemName.ToLower();
                        if (lowerName.Contains("4")) ram = 4;
                        else if (lowerName.Contains("8")) ram = 8;
                        else if (lowerName.Contains("16")) ram = 16;
                        else if (lowerName.Contains("32")) ram = 32;
                        else if (vps > 0) ram = vps;

                        // 🔹 Use your new pricing logic
                        int pricePerUnitINR = GetPrice(ip, ram);
                        double totalPriceINR = pricePerUnitINR * qty;

                        result.Add(new HostOffer
                        {
                            ItemName = itemName,
                            IP = ip,
                            VPS = vps,
                            Qty = qty,
                            PID = pid,
                            PricePerUnit = pricePerUnitINR,
                            TotalPrice = totalPriceINR
                        });
                    }
                    catch
                    {
                        // Ignore malformed entries
                        continue;
                    }
                }
            }
        }
        catch
        {
            // Ignore network or parsing errors
        }

        // 🔹 Cache for 5 minutes
        HttpRuntime.Cache.Insert(cacheKey, result, null,
            DateTime.UtcNow.AddMinutes(5),
            System.Web.Caching.Cache.NoSlidingExpiration);

        return result;
    }


    protected void rptHostDzire_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            return;

        // Controls
        var ddlRam = (DropDownList)e.Item.FindControl("ddlHostRam");
        var lblPrice = (HtmlGenericControl)e.Item.FindControl("lblHostPrice");
        var hdnVps = (HiddenField)e.Item.FindControl("hdnHostVPS");

        // Data bound object (HostOffer)
        dynamic offer = e.Item.DataItem;
        if (offer == null) return;

        // ---- Populate RAM options based on VPS tier (simple heuristic) ----
        ddlRam.Items.Clear();
        int vpsTier = 0;
        try { vpsTier = Convert.ToInt32(offer.VPS); } catch { vpsTier = 1; }

        // Heuristic mapping: customize to match real data
        
      
       
            ddlRam.Items.Add(new ListItem("4 GB", "4"));
        ddlRam.Items.Add(new ListItem("8 GB", "8"));
        ddlRam.Items.Add(new ListItem("16 GB", "16"));
        ddlRam.Items.Add(new ListItem("32 GB", "32"));



        // Default select first
        if (ddlRam.Items.Count > 0) ddlRam.SelectedIndex = 0;

        // ---- Ensure price label shows INR formatted value ----
        try
        {
            double price = Convert.ToDouble(offer.PricePerUnit);
            if (lblPrice != null) lblPrice.InnerText = "₹" + price.ToString("F0");
        }
        catch
        {
            // leave Eval value if parsing fails
        }

        // Optionally set hidden vps value
        if (hdnVps != null) hdnVps.Value = vpsTier.ToString();
    }

    protected async void btnHostBuyNow_Click(object sender, EventArgs e)
    {
        try
        {
            var btn = (Button)sender;
            var item = (RepeaterItem)btn.NamingContainer;

            // HostDzire item controls
            string ip = btn.CommandArgument ?? "";
            var ddlRamHost = (DropDownList)item.FindControl("ddlHostRam");
            var qtyField = (HiddenField)item.FindControl("hdnHostQty");
            var pidField = (HiddenField)item.FindControl("hdnHostPID");
            var lblHostPrice = (HtmlGenericControl)item.FindControl("lblPrice");
            var lblItemName = (HtmlGenericControl)item.FindControl("lblIN");

            string selectedRam = ddlRamHost?.SelectedValue ?? "4";
            int qty = 1;
            if (!int.TryParse(qtyField?.Value, out qty)) qty = 1;
            string pid = pidField?.Value ?? "";

            // Parse unit price (remove currency symbol if present)
            string priceText = lblHostPrice != null ? lblHostPrice.InnerText.Replace("₹", "").Trim() : "0";
            decimal unitPrice = 0m;
            decimal.TryParse(priceText,
                             System.Globalization.NumberStyles.Number,
                             System.Globalization.CultureInfo.InvariantCulture,
                             out unitPrice);

            decimal totalAmount = unitPrice * qty;
            string amountStr = totalAmount.ToString("F2", System.Globalization.CultureInfo.InvariantCulture); // e.g. "1400.00"

            // Generate transaction ID
            string txnId = "TXN" + DateTime.Now.ToString("yyyyMMddHHmmss");

            Session["SelectedPlanId"] = pid;
            Session["RAM"]  = selectedRam;
            Session["SelectedIpv4"] = ip;

            // Save selection in session if you need it later
            Session["SelectedHostItem"] = lblItemName.InnerText.ToString();
            Session["Host"] = "Yes";

            // Customer info
            string name = Session["CustomerName"]?.ToString() ?? "Guest";
            string email = Session["Email"]?.ToString() ?? "guest@example.com";
            string mobile = Session["Mobile"]?.ToString() ?? "9132678956"; // fallback

            string redirectUrl = "https://cosmosrecogserver.com/Pages/payment_detail";

            // Create order using your existing helper
            PaymentGatewayHelper PGH = new PaymentGatewayHelper();
            DAL dal = new DAL();

            var orderResponse = await PGH.CreateOrderAsync(
                txnId,
                unitPrice.ToString(),
                $"HostDzire {ip} (PID:{pid}) - {selectedRam}GB - Qty:{qty}",
                name,
                email,
                mobile,
                redirectUrl
            );

            if (orderResponse != null && orderResponse.status)
            {
                // Persist order and redirect
                dal.SaveOrder(orderResponse, txnId, unitPrice.ToString(), name, email, mobile);

                Response.Redirect(orderResponse.data.payment_url);
                Context.ApplicationInstance.CompleteRequest(); // avoid ThreadAbortException
                return;
            }
            else
            {
                // Feedback to user (simple alert)
                Response.Write("<script>alert('Order creation failed. Please try again later.');</script>");
            }
        }
        catch (Exception)
        {
            Response.Write("<script>alert('Something went wrong. Please try again later.');</script>");
        }
    }


    // ---------------------------
    // IP stock methods (cached)
    // ---------------------------
    private async Task BindIpPlans()
    {
        try
        {
            var plans = await GetAvailableIpsAsync();

            if (plans == null || !plans.Any())
            {
                Response.Write("<div class='alert alert-warning'>No IP stock available right now.</div>");
                return;
            }

            // Store lightweight data in cache (avoid heavy ViewState)
            string cacheKey = $"IpStock_Plans";
            HttpRuntime.Cache.Insert(cacheKey, plans, null, DateTime.UtcNow.AddMinutes(5), System.Web.Caching.Cache.NoSlidingExpiration);

            // For compatibility with existing code that used ViewState["AllPlans"], keep a reference
            ViewState["AllPlans"] = plans;

            BindRepeater(plans);
        }
        catch (Exception ex)
        {
            Response.Write("<div class='alert alert-danger'>Error loading IP plans: " + ex.Message + "</div>");
        }
    }

    public async Task<List<Package>> GetAvailableIpsAsync()
    {
        // Use cache first
        string cacheKey = $"IpStock_Plans";
        if (HttpRuntime.Cache[cacheKey] != null)
            return (List<Package>)HttpRuntime.Cache[cacheKey];

        using (var request = new HttpRequestMessage(HttpMethod.Post, $"{baseUrl}/ipstock"))
        {
            request.Headers.Clear();
            request.Headers.Add("Authorization", authKey);

            var response = await _httpClient.SendAsync(request).ConfigureAwait(false);
            response.EnsureSuccessStatusCode();

            var json = await response.Content.ReadAsStringAsync().ConfigureAwait(false);

            if (json.StartsWith("\"") && json.EndsWith("\""))
            {
                json = JsonConvert.DeserializeObject<string>(json);
            }

            var result = JsonConvert.DeserializeObject<ApiResponse>(json);

            if (result?.status == 1 && result.packages != null)
            {
                var packages = result.packages
                                     .Where(p => p.status == "active" && p.ipv4 > 0)
                                     .OrderByDescending(p => p.ipv4)
                                     .ToList();

                // Assign RAM based on rules
                foreach (var p in packages)
                {
                    if (p.ipv4 < 200) p.ram = 4;         // Linux
                    else if (p.ipv4 >= 200 && p.ipv4 < 400) p.ram = 8;
                    else if (p.ipv4 >= 400 && p.ipv4 < 800) p.ram = 16;
                    else p.ram = 32;
                }

                // cache results
                HttpRuntime.Cache.Insert(cacheKey, packages, null, DateTime.UtcNow.AddMinutes(5), System.Web.Caching.Cache.NoSlidingExpiration);

                return packages;
            }
        }

        return new List<Package>();
    }

    private void BindRepeater(IEnumerable<Package> plans)
    {
        string filter = ViewState["CurrentFilter"] as string ?? "All";

        if (filter == "Linux")
            plans = plans.Where(p => p.ram == 4);
        else if (filter == "Windows")
            plans = plans.Where(p => p.ram >= 8);

        var data = plans.Select(plan =>
        {
            string category = "";
            string badgeIcon = "";

            if (plan.name.ToLower().Contains("103.103") || plan.name.ToLower().Contains("103.87") ||
            plan.name.ToLower().Contains("103.54") || plan.name.ToLower().Contains("43.239"))
            {
                category = "Gold 3.0GHz";
                badgeIcon = "<i class='icon-star-full'></i>";
            }
            else if (plan.name.ToLower().Contains("103.184"))
            {
                category = "Pro AMD 3.1 GHz";
                badgeIcon = "<i class='icon-diamond1'></i>";
            }
            else
            {
                category = "Silver";
                badgeIcon = "<i class='icon-sphere'></i>";
            }

            return new
            {
                Id = plan.id,
                Title = plan.name,
                Description = $"IPv4 stock: {plan.ipv4} | RAM: {plan.ram} GB",
                Price = GetPrice(plan.name.Split(' ')[0], plan.ram),
                Badge = badgeIcon + " " + category,
                IsPopular = plan.ipv4 > 20,
                PromoText = plan.ipv4 > 100 ? "Bulk discount available!" : "",
                Ram = plan.ram,
                Ipv4 = plan.ipv4,
                FeaturesHtml = BuildFeaturesHtml(new List<string>
                {
                    $"{plan.ipv4} IPv4 addresses",
                    $"{plan.ram} GB RAM",
                    $"Status: {plan.status}",
                    "Full root access",
                    "DDoS Protection"
                })
            };
        }).ToList();

        rptIpPlans.DataSource = data;
        rptIpPlans.DataBind();
    }

    protected void ddlRamPerPlan_SelectedIndexChanged(object sender, EventArgs e)
    {
        var ddl = (DropDownList)sender;
        var item = (RepeaterItem)ddl.NamingContainer;

        // Find the price span and hidden plan id
        var lblPrice = (HtmlGenericControl)item.FindControl("lblPrice");
        var hiddenId = (HiddenField)item.FindControl("hdnPlanId");

        if (hiddenId == null || lblPrice == null) return;

        int planId = int.Parse(hiddenId.Value);
        var allPlans = ViewState["AllPlans"] as List<Package>;
        var plan = allPlans?.FirstOrDefault(p => p.id == planId);

        if (plan != null)
        {
            int selectedRam = int.Parse(ddl.SelectedValue);
            int newPrice = GetPrice(plan.name, selectedRam);

            lblPrice.InnerText = $"₹{newPrice}";
        }
    }
    protected void ddlHostRam_SelectedIndexChanged(object sender, EventArgs e)
    {
        var ddl = (DropDownList)sender;
        var item = (RepeaterItem)ddl.NamingContainer;

        var lblPrice = (HtmlGenericControl)item.FindControl("lblPrice");
        var hdnIP = (HiddenField)item.FindControl("hdnIP");
        var hdnItemName = (HiddenField)item.FindControl("hdnItemName");

        if (lblPrice == null || hdnIP == null) return;

        string ip = hdnIP.Value;
        int selectedRam = int.Parse(ddl.SelectedValue);
        int newPrice = GetPrice(ip, selectedRam);

        lblPrice.InnerText = $"₹{newPrice}";
    }


    private string BuildFeaturesHtml(List<string> features)
    {
        return string.Join("", features.Select(f => $"<li><i class='icon-check'></i> {f}</li>"));
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        string query = txtSearch.Text.Trim().ToLower();

        // 🔹 SmartVPS Plans
        var allPlans = ViewState["AllPlans"] as List<Package>;
        if (allPlans != null)
        {
            var filtered = allPlans
                .Where(p =>
                    (p.name ?? "").ToLower().Contains(query) ||
                    p.id.ToString().Contains(query) ||
                    (p.status ?? "").ToLower().Contains(query)
                ).ToList();

            BindRepeater(filtered);
        }

        // 🔹 HostDzire Plans
        var allHostDzire = ViewState["HostDzirePlans"] as List<HostOffer>;
        if (allHostDzire != null)
        {
            var filteredHost = allHostDzire
                .Where(p =>
                    (p.IP ?? "").ToLower().Contains(query) ||
                    p.VPS.ToString().Contains(query) ||
                    p.PricePerUnit.ToString().Contains(query)
                ).ToList();

            rptHostDzire.DataSource = filteredHost;
            rptHostDzire.DataBind();
            pnlNoHostDzire.Visible = filteredHost.Count == 0;
        }
    }


    protected async void rptIpPlans_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "BuyNow")
        {
            // Get repeater item controls
            var lblPrice = (HtmlGenericControl)e.Item.FindControl("lblPrice");
            var ddlRam = (DropDownList)e.Item.FindControl("ddlRamPerPlan");
            var hdnPlanId = (HiddenField)e.Item.FindControl("hdnPlanId");
            var hdnIpv4 = (HiddenField)e.Item.FindControl("hdnIpv4");

            // Safely read values
            string amount = lblPrice != null ? lblPrice.InnerText.Replace("₹", "").Trim() : "0";
            string planId = hdnPlanId != null ? hdnPlanId.Value : "0";
            string ramSelected = ddlRam != null ? ddlRam.SelectedValue : "4";
            string ipv4Count = hdnIpv4 != null ? hdnIpv4.Value : "0";

            // Generate transaction ID
            string txnId = "TXN" + DateTime.Now.ToString("yyyyMMddHHmmss");

            // Store in Session for later use
            Session["SelectedPlanId"] = planId;
            Session["SelectedRam"] = ramSelected;
            Session["SelectedIpv4"] = ipv4Count;
            Session["Host"] = "No";


            // Get customer info from session
            string name = Session["CustomerName"]?.ToString() ?? "Guest";
            string email = Session["Email"]?.ToString() ?? "guest@example.com";
            string mobile = "9132678956"; // Or get from session/form

            string redirectUrl = "https://cosmosrecogserver.com/Pages/payment_detail";

            PaymentGatewayHelper PGH = new PaymentGatewayHelper();
            DAL dal = new DAL();

            // Call API with RAM + IPv4 included
            var orderResponse = await PGH.CreateOrderAsync(
                txnId,
                amount,
                $"Plan #{planId} - {ramSelected}GB RAM - {ipv4Count} IPv4",
                name,
                email,
                mobile,
                redirectUrl
            );

            if (orderResponse != null && orderResponse.status)
            {
                // Save in DB
                dal.SaveOrder(orderResponse, txnId, amount, name, email, mobile);

                // Redirect user to payment URL
                Response.Redirect(orderResponse.data.payment_url);
                Context.ApplicationInstance.CompleteRequest(); // prevent ThreadAbortException
            }
            else
            {
                // handle failure (show message, log, etc.)
            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        var button = (Button)sender;

        // Reset styles
        btnAll.CssClass = "btn btn-outline-primary";
        btnLinux.CssClass = "btn btn-outline-primary";
        btnWindows.CssClass = "btn btn-outline-primary";

        button.CssClass = "btn btn-outline-primary active";

        ViewState["CurrentFilter"] = button.CommandArgument; // Save filter

        // 🔹 Filter SmartVPS Plans
        var allPlans = ViewState["AllPlans"] as List<Package>;
        if (allPlans != null)
            BindRepeater(allPlans); // Filtering handled inside BindRepeater()

        // 🔹 Filter HostDzire Plans
        var allHostDzire = ViewState["HostDzirePlans"] as List<HostOffer>;
        if (allHostDzire != null)
        {
            IEnumerable<HostOffer> filtered = allHostDzire;
            string filter = button.CommandArgument;

            if (filter == "Linux")
                filtered = allHostDzire.Where(p => p.VPS <= 2);
            else if (filter == "Windows")
                filtered = allHostDzire.Where(p => p.VPS > 2);

            rptHostDzire.DataSource = filtered.ToList();
            rptHostDzire.DataBind();
            pnlNoHostDzire.Visible = !filtered.Any();
        }
    }


    private int GetPrice(string ip, int ram)
    {
        ip = ip?.ToLower() ?? "";

        // 🔹 Gold IP ranges (HostDzire)
        if (ip.Contains("163.223") || ip.Contains("163.227"))
        {
            if (ram == 4) return 700;
            if (ram == 8) return 1300;
            if (ram == 16) return 2500;
            if (ram == 32) return 5000;
        }

        // 🔹 Gold IP ranges (SmartVPS legacy)
        if (ip.Contains("103.103") || ip.Contains("103.87") ||
            ip.Contains("103.54") || ip.Contains("43.239"))
        {
            if (ram == 8) return 1300;
            if (ram == 16) return 2000;
            if (ram == 32) return 2600;
        }

        // 🔹 Diamond Pro (AMD)
        if (ip.Contains("103.184"))
        {
            if (ram == 16) return 2500;
            if (ram == 32) return 2900;
        }

        // 🔹 Default / Silver
        if (ram == 4) return 650;
        if (ram == 8) return 900;
        if (ram == 16) return 1300;
        if (ram == 32) return 2450;

        // 🔹 Fallback: if none matched (unknown IP or RAM)
        // Pick the closest default or minimum safe value
        if (ram < 4) return 650;   // treat as 4GB minimum
        if (ram > 32) return 2450; // treat as 32GB maximum
        return 900; // safe mid-tier fallback (8GB pricing)
    }



    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        var allPlans = ViewState["AllPlans"] as List<Package>;
        if (allPlans != null) BindRepeater(allPlans);
    }

    protected void rptIpPlans_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            return;

        // Controls from the repeater item
        var ddlRam = (DropDownList)e.Item.FindControl("ddlRamPerPlan");
        var lblPrice = (HtmlGenericControl)e.Item.FindControl("lblPrice");
        var hdnPlanId = (HiddenField)e.Item.FindControl("hdnPlanId");
        var hdnIpv4 = (HiddenField)e.Item.FindControl("hdnIpv4");

        if (ddlRam == null || lblPrice == null)
            return;

        // DataItem was bound in BindRepeater() as an anonymous object — use dynamic to read fields
        dynamic plan = e.Item.DataItem;
        if (plan == null) return;

        // Clear & populate RAM options based on IP/category
        ddlRam.Items.Clear();
        string ipTitle = (plan.Title ?? "").ToString().ToLower();

        if (ipTitle.Contains("103.184"))
        {
            // Diamond: only 16 & 32
            ddlRam.Items.Add(new ListItem("16 GB", "16"));
            ddlRam.Items.Add(new ListItem("32 GB", "32"));
        }
        else if (ipTitle.Contains("103.103") || ipTitle.Contains("103.87") ||
                 ipTitle.Contains("103.54") || ipTitle.Contains("43.239"))
        {
            // Gold: 8, 16, 32
            ddlRam.Items.Add(new ListItem("8 GB", "8"));
            ddlRam.Items.Add(new ListItem("16 GB", "16"));
            ddlRam.Items.Add(new ListItem("32 GB", "32"));
        }
        else
        {
            // Default: 4,8,16,32
            ddlRam.Items.Add(new ListItem("4 GB", "4"));
            ddlRam.Items.Add(new ListItem("8 GB", "8"));
            ddlRam.Items.Add(new ListItem("16 GB", "16"));
            ddlRam.Items.Add(new ListItem("32 GB", "32"));
        }

        // Default selection depends on current filter or plan.Ram
        string filter = ViewState["CurrentFilter"] as string ?? "All";

        if (filter == "Linux")
        {
            if (ddlRam.Items.FindByValue("4") != null)
                ddlRam.SelectedValue = "4";
            else
                ddlRam.SelectedIndex = 0;
        }
        else if (filter == "Windows")
        {
            // Remove 4 if present
            var item4 = ddlRam.Items.FindByValue("4");
            if (item4 != null) ddlRam.Items.Remove(item4);

            if (ddlRam.Items.FindByValue("8") != null)
                ddlRam.SelectedValue = "8";
            else if (ddlRam.Items.Count > 0)
                ddlRam.SelectedIndex = 0;
        }
        else
        {
            // Try to match the plan's ram value if provided
            try
            {
                int planRam = Convert.ToInt32(plan.Ram);
                if (ddlRam.Items.FindByValue(planRam.ToString()) != null)
                    ddlRam.SelectedValue = planRam.ToString();
                else
                    ddlRam.SelectedIndex = 0;
            }
            catch
            {
                ddlRam.SelectedIndex = 0;
            }
        }

        // Update price label based on selected RAM
        int selectedRam = int.Parse(ddlRam.SelectedValue);
        string titleForPrice = (plan.Title ?? "").ToString();
        int price = GetPrice(titleForPrice, selectedRam);
        lblPrice.InnerText = $"₹{price}";

        // Also set hidden fields if present
        if (hdnPlanId != null) hdnPlanId.Value = (plan.Id ?? 0).ToString();
        if (hdnIpv4 != null) hdnIpv4.Value = (plan.Ipv4 ?? 0).ToString();
    }


    // ------------ Models ------------
    [Serializable]
    public class Package
    {
        public int id { get; set; }
        public string name { get; set; }
        public int ipv4 { get; set; }
        public string status { get; set; }
        public int ram { get; set; }
    }

    public class ApiResponse
    {
        public int status { get; set; }
        public string message { get; set; }
        public List<Package> packages { get; set; }
    }

    // HostDzire offer model
    public class HostOffer
    {
        public string ItemName { get; set; }
        public string IP { get; set; }
        public int VPS { get; set; }
        public int Qty { get; set; }
        public string PID { get; set; }
        public double PricePerUnit { get; set; }
        public double TotalPrice { get; set; }
    }
}
