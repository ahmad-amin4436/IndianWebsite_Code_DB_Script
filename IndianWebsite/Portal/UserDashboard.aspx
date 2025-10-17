<%@ Page Title="User Dashboard" Async="true" Language="C#" MasterPageFile="~/Portal.master" AutoEventWireup="true" CodeFile="UserDashboard.aspx.cs" Inherits="Portal_UserDashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="section">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title gradient-text">📊 Dashboard</h2>
                <p class="section-subtitle">Overview of your account and services</p>
            </div>

            <!-- Welcome -->
            <div class="row mb-4">
                <div class="col-md-12 text-center">
                    <h4>Welcome back, <asp:Label ID="lblUserName" runat="server" Text="User"></asp:Label>!</h4>
                    <p>Here's what's happening with your services</p>
                    <p><strong><%= DateTime.Now.ToString("ddd, dd MMM yyyy") %></strong></p>
                </div>
            </div>

            <!-- Overview Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="pricing-card">
                        <h6>Total Orders</h6>
                        <h3><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></h3>
                        <p>All time</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="pricing-card">
                        <h6>Active Services</h6>
                        <h3><asp:Label ID="lblActiveServices" runat="server" Text="0"></asp:Label></h3>
                        <p>Running</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="pricing-card">
                        <h6>Total Spent</h6>
                        <h3>₹<asp:Label ID="lblTotalSpent" runat="server" Text="0"></asp:Label></h3>
                        <p>Lifetime</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="pricing-card">
                        <h6>Pending</h6>
                        <h3><asp:Label ID="lblPendingOrders" runat="server" Text="0"></asp:Label></h3>

                        <p>Attention</p>
                    </div>
                </div>
            </div>

            <!-- Order Status -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="pricing-card">
                        <h5>Order Status</h5>
                        <div class="row text-center">
                            <div class="col-md-4">
                                <h6>Completed</h6>
                                <h4><asp:Label ID="lblCompletedOrders" runat="server" Text="0"></asp:Label></h4>
                            </div>
                            <div class="col-md-4">
                                <h6>Pending</h6>
                                <h4><asp:Label ID="lblPendingStatus" runat="server" Text="0"></asp:Label></h4>
                            </div>
                            <div class="col-md-4">
                                <h6>Failed</h6>
                                <h4><asp:Label ID="lblFailedOrders" runat="server" Text="0"></asp:Label></h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Account Information -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="pricing-card">
                        <h5>Account Information</h5>
                        <p><strong>Name:</strong> <asp:Label ID="lblAccName" runat="server"></asp:Label></p>
                        <p><strong>Email:</strong> <asp:Label ID="lblAccEmail" runat="server"></asp:Label></p>
                        <p><strong>Member Since:</strong> <asp:Label ID="lblMemberSince" runat="server"></asp:Label></p>
                        <p><strong>Account Status:</strong> Active</p>
                    </div>
                </div>
            </div>

            <!-- Recent Orders -->
            <div class="row">
                <div class="col-md-12">
                    <div class="pricing-card">
                        <h5>Recent Orders</h5>
                        <asp:Repeater ID="rptRecentOrders" runat="server">
    <HeaderTemplate>
        <table class="table table-bordered text-center">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>IP</th>
                    <th>OS</th>
                    <th>RAM</th>
                    <th>Status</th>
<%--                    <th>Power</th>--%>
                    <th>Expiry</th>
                </tr>
            </thead>
            <tbody>
    </HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Eval("ClientTransactionID") %></td>
            <td><%# Eval("IP") %></td>
            <td><%# Eval("OS") %></td>
            <td><%# Eval("RAM") %></td>
            <td><span class="badge bg-info"><%# Eval("ActionStatus") %></span></td>
            <%--<td><span class="badge 
                <%# Eval("PowerStatus").ToString() == "Running" ? "bg-success" : "bg-danger" %>">
                <%# Eval("PowerStatus") %></span>
            </td>--%>
            <td><%# Eval("ExpiryDate", "{0:dd-MMM-yyyy}") %></td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

                        <asp:Label ID="lblNoOrders" runat="server" Text="No recent orders found" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <style>
    .table tbody tr td {
        color: #fff; /* white text */
    }
    .table thead tr th {
        color: #fff; /* make header white too */
    }
</style>

</asp:Content>
