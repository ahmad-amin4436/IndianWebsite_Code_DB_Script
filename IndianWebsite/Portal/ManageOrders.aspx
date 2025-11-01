<%@ Page Title="Manage Orders" Async="true" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeFile="ManageOrders.aspx.cs" Inherits="Portal_ManageOrders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Transparent Card with Gradient Border Glow */
        .gradient-card {
            position: relative;
            border-radius: 16px;
            padding: 2px;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #ff00ff, #00ffff, #ff9900);
            box-shadow: 0 0 15px rgba(255, 0, 255, 0.6);
            transition: all 0.3s ease;
        }
        .gradient-card:hover {
            box-shadow: 0 0 30px rgba(0, 255, 255, 0.9);
            transform: translateY(-4px);
        }
        .gradient-card .card-body {
            background: transparent !important;
            border-radius: 14px;
            color: #f5f5f5;
            padding: 20px;
        }
    </style>

    <section class="container-xxl py-5">
        <!-- Page Header -->
        <div class="text-center mb-5">
            <h2 class="fw-bold text-gradient">Manage Orders</h2>
            <p class="text-muted">Browse and manage your servers by IP.</p>
            <p class="text-muted">NOTE: Don't try to perform any action while Server is under "Processing or Pending"</p>
        </div>

      

                <!-- Search -->
                <div class="row mb-4 justify-content-center">
                    <div class="col-md-6">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server"
                                placeholder="Search by IP..."
                                CssClass="form-control form-control-lg bg-dark text-light border-0 shadow-sm"
                                AutoPostBack="true"
                                OnTextChanged="txtSearch_TextChanged" />
                            <asp:Button ID="btnClear" runat="server"
                                Text="Clear"
                                CssClass="btn btn-outline-primary btn-lg"
                                OnClick="btnClear_Click" />
                        </div>
                    </div>
                </div>
                                                                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

                <!-- Orders List -->
                <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound" OnItemCommand="rptOrders_ItemCommand">
                    <ItemTemplate>
                        <div class="gradient-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <!-- Server Info -->
                                <div>
                                    <h5 class="fw-bold mb-2">
                                        🖥️ <%# Eval("OS") %> 
                                        <span class="text-info">| <%# Eval("RAM") %></span>
                                    </h5>
                                    <p class="mb-1">
                                        <strong>IP:</strong> <%# Eval("IP") %>
                                        <a href="javascript:void(0);" 
                                           onclick="copyToClipboard('<%# Eval("IP") %>')" 
                                           title="Copy IP">
                                            <i class="icon-copy"></i>  <%-- DarkStar copy icon class --%>
                                        </a>
                                    </p>

                                   <p class="mb-1">
                                        <strong>Username:</strong> <%# Eval("Username") %>
                                        <a href="javascript:void(0);" 
                                           onclick="copyToClipboard('<%# Eval("Username") %>')" 
                                           title="Copy Username">
                                            <i class="icon-copy"></i>  <%-- DarkStar copy icon class --%>
                                        </a>
                                    </p>

                                    <p class="mb-1">
                                        <strong>Password:</strong> <%# Eval("Password") %>
                                        <a href="javascript:void(0);" 
                                           onclick="copyToClipboard('<%# Eval("Password") %>')" 
                                           title="Copy Password">
                                            <i class="icon-copy"></i>
                                        </a>
                                    </p>


                                    <p class="mb-2"><strong>Expires:</strong> <%# Eval("ExpiryDate") %></p>
                                    <p class="mb-2"><strong>Customer Name:</strong> <%# Eval("CustomerName") %></p>
                                    <p class="mb-2"><strong>Email:</strong> <%# Eval("Email") %></p>

                                    <span class="badge 
                                        <%# Eval("ActionStatus").ToString() == "Active" ? "bg-success" : 
                                             Eval("ActionStatus").ToString() == "Pending" ? "bg-warning text-dark" : 
                                             Eval("ActionStatus").ToString() == "Expired" ? "bg-secondary" : "bg-danger" %>">
                                        <%# Eval("ActionStatus") %>
                                    </span>

                                </div>

                                <!-- Actions -->
                                <div class="d-flex flex-column gap-2">
                                    <asp:Button ID="btnStartStop" runat="server" 
                                        Text='<%# Eval("PowerStatus").ToString().ToLower() == "offline" ? "Start" : "Stop" %>' 
                                        CommandName="StartStop" 
                                        CommandArgument='<%# Eval("IP") %>' 
                                        CssClass="btn btn-outline-success btn-sm w-100" />

                                    <asp:Button ID="btnFormat" runat="server" 
                                        Text="Format" 
                                        CommandName="Format" 
                                        CommandArgument='<%# Eval("IP") %>' 
                                        CssClass="btn btn-outline-danger btn-sm w-100" />

                                    <asp:DropDownList ID="ddlChangeOS" runat="server"
                                        CssClass="form-select form-select-sm bg-dark text-light"
                                        AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlChangeOS_SelectedIndexChanged">
                                    </asp:DropDownList>

                                    <asp:HiddenField ID="hfIP" runat="server" Value='<%# Eval("IP") %>' />
                                    <asp:HiddenField ID="hfOS" runat="server" Value='<%# Eval("OS") %>' />
                                    <asp:HiddenField ID="hfRAM" runat="server" Value='<%# Eval("RAM") %>' />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <!-- No Records -->
                <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                    <div class="alert alert-dark text-center shadow-sm">
                        ℹ️ No orders found.
                    </div>
                </asp:Panel>

    </section>
    <script>
function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(function () {
        //alert("Copied: " + text);
    }, function () {
        //alert("Failed to copy. Please try again.");
    });
}
</script>

</asp:Content>
