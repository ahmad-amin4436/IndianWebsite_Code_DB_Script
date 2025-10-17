using System;
using System.Data;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;

public partial class Portal_UserDashboard : Page
{
    DAL dal = new DAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboard();
        }
    }

    private async void LoadDashboard()
    {
        int userId = Convert.ToInt32(Session["UserID"] ?? "1"); // fallback for demo
        DataSet ds = dal.GetUserDashboardData(userId);

        if (ds.Tables.Count >= 4)
        {
            // --- User Info ---
            if (ds.Tables[0].Rows.Count > 0)
            {
                var row = ds.Tables[0].Rows[0];
                lblUserName.Text = row["FullName"].ToString();
                lblAccName.Text = row["FullName"].ToString();
                lblAccEmail.Text = row["Email"].ToString();
                lblMemberSince.Text = Convert.ToDateTime(row["CreatedDate"]).ToString("MMM yyyy");
            }

            // --- Orders Summary ---
            if (ds.Tables[1].Rows.Count > 0)
            {
                var row = ds.Tables[1].Rows[0];
                lblTotalOrders.Text = row["TotalOrders"].ToString();
                lblActiveServices.Text = row["ActiveServices"].ToString();
                lblPendingOrders.Text = row["PendingOrders"].ToString();
                lblCompletedOrders.Text = row["CompletedOrders"].ToString();
                lblFailedOrders.Text = row["FailedOrders"].ToString();
                lblPendingStatus.Text = row["PendingOrders"].ToString();
            }

            // --- Total Spent ---
            if (ds.Tables[2].Rows.Count > 0)
            {
                lblTotalSpent.Text = ds.Tables[2].Rows[0]["TotalSpent"].ToString();
            }

            // --- Recent Orders (DB + API merge) ---
            if (ds.Tables[3].Rows.Count > 0)
            {
                DataTable recentOrders = ds.Tables[3].Clone();
                recentOrders.Columns.Add("PowerStatus"); // extra API column

                foreach (DataRow dbRow in ds.Tables[3].Rows)
                {
                    var apiData = await GetServerStatusAsync(dbRow["IP"].ToString(), dbRow["RAM"].ToString());
                    DataRow merged = recentOrders.NewRow();

                    merged["ClientTransactionID"] = dbRow["ClientTransactionID"];
                    merged["IP"] = dbRow["IP"];
                    merged["OS"] = apiData?.OS ?? dbRow["OS"];
                    merged["RAM"] = apiData?.RAM ?? dbRow["RAM"];
                    merged["ActionStatus"] = apiData?.ActionStatus ?? dbRow["ActionStatus"];
                    merged["ExpiryDate"] = apiData?.ExpiryDate ?? dbRow["ExpiryDate"];
                    merged["PowerStatus"] = apiData?.PowerStatus ?? "Unknown";

                    recentOrders.Rows.Add(merged);
                }

                rptRecentOrders.DataSource = recentOrders;
                rptRecentOrders.DataBind();
                lblNoOrders.Visible = false;
            }
            else
            {
                rptRecentOrders.Visible = false;
                lblNoOrders.Visible = true;
            }
        }
    }

    private async Task<ApiResponse> GetServerStatusAsync(string ip, string ram)
    {
        try
        {
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Add("Authorization", "Basic U0NCSEFJOmZmZ2d2Y2hnNzg4Nw==");

                var payload = new { ip = ip, ram = ram };
                var content = new StringContent(JsonConvert.SerializeObject(payload), Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync("https://smartvps.online/api/oceansmart/status", content);
                if (response.IsSuccessStatusCode)
                {
                    string json = await response.Content.ReadAsStringAsync();
                    if (!string.IsNullOrWhiteSpace(json) && json.TrimStart().StartsWith("{"))
                    {
                        return JsonConvert.DeserializeObject<ApiResponse>(json);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("API error: " + ex.Message);
        }
        return null;
    }

    public class ApiResponse
    {
        public string IP { get; set; }
        public string OS { get; set; }
        public string Usernane { get; set; } // API typo preserved
        public string Password { get; set; }
        public string ActionStatus { get; set; }
        public string MachineStatus { get; set; }
        public string PowerStatus { get; set; }
        public string RAM { get; set; }
        public string ExpiryDate { get; set; }
    }
}
