using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using static PaymentGatewayHelper;

/// <summary>
/// Summary description for DAL //
/// </summary>
public class DAL
{
    string cs = ConfigurationManager.ConnectionStrings["IndianWebsite"].ToString();
    public DAL()
    {
        
    }
    public bool SaveUserData(string FullName,string Email, string Password, string ConfirmPassword)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("SP_UserRegistration",con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", 1);
                cmd.Parameters.AddWithValue("@FullName", FullName);
                cmd.Parameters.AddWithValue("@Email", Email);
                cmd.Parameters.AddWithValue("@Password", Password);
                cmd.Parameters.AddWithValue("@ConfirmPassword", ConfirmPassword);
                con.Open();
                int rowAfftected = (int)cmd.ExecuteNonQuery();
                con.Close();
                if (rowAfftected > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
    }
    public long CheckUser(string Email, string Password)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("SP_UserRegistration", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", 2);
                cmd.Parameters.AddWithValue("@Email", Email);
                cmd.Parameters.AddWithValue("@Password", Password);
                con.Open();
                object result = cmd.ExecuteScalar();
                con.Close();

                if (result != null && result != DBNull.Value)
                {
                    long userId = Convert.ToInt64(result);
                    return userId;
                }
                else
                {
                    return 0;
                }
            }
        }
    }

    public void SaveOrder(CreateOrderResponse order, string txnId, string amount, string name, string email, string mobile)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string query = @"INSERT INTO PaymentOrders 
                             (ClientTxnId, OrderId, Amount, CustomerName, CustomerEmail, CustomerMobile, PaymentUrl)
                             VALUES (@ClientTxnId, @OrderId, @Amount, @CustomerName, @CustomerEmail, @CustomerMobile, @PaymentUrl)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ClientTxnId", txnId);
                cmd.Parameters.AddWithValue("@OrderId", order.data.order_id);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@CustomerName", name);
                cmd.Parameters.AddWithValue("@CustomerEmail", email);
                cmd.Parameters.AddWithValue("@CustomerMobile", mobile);
                cmd.Parameters.AddWithValue("@PaymentUrl", order.data.payment_url);
                cmd.ExecuteNonQuery();
                con.Close();

            }
        }
    }
    public void UpdatePaymentStatus(string txnId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand("SP_UpdatePaymentStatus", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ClientTxnId", txnId);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public DataRow GetPaymentOrder(string txnId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand("SP_GetPaymentOrder", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ClientTxnId", txnId);

            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                con.Open();
                da.Fill(dt);
                con.Close();
                if (dt.Rows.Count > 0)
                    return dt.Rows[0];
                return null;
            }
        }
    }

    public void InsertVpsOrder(string clientTxnId, int? userId, string ip, string os,
                               string username, string password, string actionStatus,
                               string machineStatus, string powerStatus, string ram, DateTime expiryDate)
    {
        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand("SP_InsertVpsOrder", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ClientTransactionID", clientTxnId);
            cmd.Parameters.AddWithValue("@UserID", (object)userId ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@IP", (object)ip ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@OS", (object)os ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Username", (object)username ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@Password", (object)password ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ActionStatus", (object)actionStatus ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@MachineStatus", (object)machineStatus ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@PowerStatus", (object)powerStatus ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@RAM", (object)ram ?? DBNull.Value);
            cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }
    }
    public DataTable GetOrders(int userId, string search)
    {
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("SP_GetOrders", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@Keyword", string.IsNullOrEmpty(search) ? "" : search);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        return dt;
    }
    public DataTable GetOrdersForAdmin(int userId, string search)
    {
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("SP_GetOrdersForAdmin", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Keyword", string.IsNullOrEmpty(search) ? "" : search);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        return dt;
    }
    public DataSet GetUserDashboardData(int userId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        using (SqlCommand cmd = new SqlCommand("sp_GetUserDashboardData", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);

            return ds;
        }
    }
    public DataTable GetUserProfile(int userId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("sp_GetUserProfile", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }

    public void DeleteUser(int userId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM UserRegistration WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", userId);
            con.Open();
            cmd.ExecuteNonQuery();
        }
    }
    public bool ChangePassword(int userId, string currentPassword, string newPassword)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("sp_ChangePassword", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", userId);
            cmd.Parameters.AddWithValue("@CurrentPassword", currentPassword);
            cmd.Parameters.AddWithValue("@NewPassword", newPassword);

            con.Open();
            int result = Convert.ToInt32(cmd.ExecuteScalar());
            return result == 1; // 1 = success, 0 = wrong current password
        }
    }
}