using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadProductFromQuery();
        }
    }
    private void LoadProductFromQuery()
    {
        var qs = Request.QueryString;
        if (qs == null || qs.Count == 0 || string.IsNullOrEmpty(qs["title"]))
        {
            // No product info provided
            pnlProduct.Visible = false;
            pnlNoProduct.Visible = true;
            return;
        }
        Session["RAM"] = (qs["ram"] ?? "").Replace("GB DDR4 RAM", "");
        string productId = qs["productId"] ?? string.Empty;
        string title = qs["title"] ?? "";
        string desc = qs["desc"] ?? "";
        string price = qs["price"] ?? "";
        string oldprice = qs["oldprice"] ?? "";
        string period = qs["period"] ?? "";
        // Specs: cpu, ram, storage, bandwidth, iprange (optional)
        var specs = new List<string>();
        if (!string.IsNullOrEmpty(qs["cpu"])) specs.Add($"<strong>CPU:</strong> {Server.HtmlEncode(qs["cpu"])}");
        if (!string.IsNullOrEmpty(qs["ram"])) specs.Add($"<strong>RAM:</strong> {Server.HtmlEncode(qs["ram"])}");
        if (!string.IsNullOrEmpty(qs["storage"])) specs.Add($"<strong>Storage:</strong> {Server.HtmlEncode(qs["storage"])}");
        if (!string.IsNullOrEmpty(qs["bandwidth"])) specs.Add($"<strong>Bandwidth:</strong> {Server.HtmlEncode(qs["bandwidth"])}");
        if (!string.IsNullOrEmpty(qs["iprange"])) specs.Add($"<strong>IP Range:</strong> {Server.HtmlEncode(qs["iprange"])}");
        // Features: pipe-separated (|) or comma-separated
        List<string> features = new List<string>();
        if (!string.IsNullOrEmpty(qs["features"]))
        {
            // support both | and ,
            var raw = qs["features"];
            var parts = raw.Split(new[] { '|', ',' }, StringSplitOptions.RemoveEmptyEntries);
            foreach (var p in parts)
            {
                features.Add(Server.HtmlEncode(p.Trim()));
            }
        }
        // Fill controls
        lblPlanTitle.Text = Server.HtmlEncode(title);
        lblPlanDesc.Text = Server.HtmlEncode(desc);
        lblPrice.Text = price.Length > 0 ? ("₹" + Server.HtmlEncode(price)) : string.Empty;
        lblOldPrice.Text = oldprice.Length > 0 ? ("₹" + Server.HtmlEncode(oldprice)) : string.Empty;
        lblPeriod.Text = Server.HtmlEncode(period);
        hfProductId.Value = Server.HtmlEncode(productId);
        // Build specs HTML
        var sbSpecs = new StringBuilder();
        sbSpecs.AppendLine("<ul class=\"list-unstyled\">\n");
        foreach (var s in specs)
        {
            sbSpecs.AppendLine($" <li>{s}</li>");
        }
        sbSpecs.AppendLine("</ul>");
        litSpecs.Text = sbSpecs.ToString();
        // Build features HTML
        var sbFeat = new StringBuilder();
        sbFeat.AppendLine("<ul>");
        foreach (var f in features)
        {
            sbFeat.AppendLine($" <li>{f}</li>");
        }
        sbFeat.AppendLine("</ul>");
        litFeatures.Text = sbFeat.ToString();
        pnlProduct.Visible = true;
        pnlNoProduct.Visible = false;
    }
    protected void btnProceed_Click(object sender, EventArgs e)
    {
        // Example: redirect to a payment page with product info preserved.
        var qs = Request.QueryString;
        var sb = new StringBuilder();
        sb.Append("payment.aspx?");
        // preserve the important parameters
        AppendIfExists(qs, sb, "productId");
        AppendIfExists(qs, sb, "title");
        AppendIfExists(qs, sb, "price");
        AppendIfExists(qs, sb, "period");
        // Remove trailing & if present
        var url = sb.ToString().TrimEnd('&');
        Response.Redirect(url);
    }
    private void AppendIfExists(System.Collections.Specialized.NameValueCollection qs, StringBuilder sb, string key)
    {
        if (qs == null) return;
        var val = qs[key];
        if (!string.IsNullOrEmpty(val))
        {
            sb.Append($"{key}={Server.UrlEncode(val)}&");
        }
    }
    protected async void btnPay_Click(object sender, EventArgs e)
    {
        string txnId = "TXN" + DateTime.Now.ToString("yyyyMMddHHmmss");
        string amount = lblPrice.Text.Replace("₹", "").Trim();
        string product = lblPlanTitle.Text.Trim();
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string redirectUrl = "https://cosmosrecogserver.com/Pages/payment_detail";
        PaymentGatewayHelper PGH = new PaymentGatewayHelper();
        DAL dal = new DAL();
        // Call API
        var orderResponse = await PGH.CreateOrderAsync(txnId, amount, product, name, email, mobile, redirectUrl);

        if (orderResponse != null && orderResponse.status)
        {
            // Save in DB
            dal.SaveOrder(orderResponse, txnId, amount, name, email, mobile);

            // Redirect user to payment URL
            Response.Redirect(orderResponse.data.payment_url);
        }
        else
        {
            //lblMessage.Text = "Order creation failed: " + (orderResponse?.msg ?? "Unknown error");
        }
    }

}