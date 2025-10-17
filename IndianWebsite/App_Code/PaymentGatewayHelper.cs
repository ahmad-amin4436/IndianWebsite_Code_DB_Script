using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;  // Install-Package Newtonsoft.Json

public class PaymentGatewayHelper
{
    private readonly string apiUrl = "https://api.ekqr.in/api/create_order";
    //private readonly string apiKey = "210d7af4-5486-45d5-8442-0fb04bc3855d"; // your key
    private readonly string apiKey = "9475c1d5-d88b-4d3f-8010-6d0b03b708df"; // your key

    public async Task<CreateOrderResponse> CreateOrderAsync(string txnId, string amount, string product, string name, string email, string mobile, string redirectUrl)
    {
        using (var client = new HttpClient())
        {
            var body = new
            {
                key = apiKey,
                client_txn_id = txnId,
                amount = amount,
                p_info = product,
                customer_name = name,
                customer_email = email,
                customer_mobile = mobile,
                redirect_url = redirectUrl,
                udf1 = "user defined field 1 (max 25 char)",
                udf2 = "user defined field 1 (max 25 char)",
                udf3 = "user defined field 1 (max 25 char)"
            };

            var json = JsonConvert.SerializeObject(body);
            var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");

            var response = await client.PostAsync(apiUrl, content);
            var result = await response.Content.ReadAsStringAsync();

            return JsonConvert.DeserializeObject<CreateOrderResponse>(result);
        }
    }
    public class CreateOrderResponse
    {
        public bool status { get; set; }
        public string msg { get; set; }
        public OrderData data { get; set; }
    }

    public class OrderData
    {
        public int order_id { get; set; }
        public string payment_url { get; set; }
    }

}
