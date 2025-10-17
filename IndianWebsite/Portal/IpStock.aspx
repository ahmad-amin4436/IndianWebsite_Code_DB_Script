<%@ Page Title="IP Stock" Async="true" Language="C#" MasterPageFile="~/Portal.master" AutoEventWireup="true" CodeFile="IpStock.aspx.cs" Inherits="Portal_IpStock" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="section">
        <div class="container">

          

            <!-- Page header (existing) -->
            <div class="text-center mb-5 mt-5">
                <h2 class="section-title gradient-text">🌐 IP Stock</h2>
                <p class="section-subtitle">Browse and purchase available servers with premium rotating IPs.</p>
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <!-- Search -->
                    <div class="row mb-4">
                        <!-- Search Box -->
                        <div class="col-md-6 offset-md-3 mb-3">
                            <div class="input-group">
                                <asp:TextBox ID="txtSearch" runat="server"
                                    placeholder="Search IP Address..."
                                    CssClass="form-control form-control-lg bg-dark text-light border-0 shadow-sm"
                                    AutoPostBack="true"
                                    OnTextChanged="txtSearch_TextChanged" />
                                <asp:Button ID="btnClear" runat="server"
                                    Text="Clear"
                                    CssClass="btn btn-secondary"
                                    OnClick="btnClear_Click" />
                            </div>
                        </div>

                        <!-- Filter Buttons -->
                        <div class="col-md-6 offset-md-3 text-center">
                            <div class="btn-group" role="group">
                                <asp:Button ID="btnAll" runat="server"
                                    CssClass="btn btn-outline-primary active"
                                    Text="All"
                                    CommandArgument="All"
                                    OnClick="btnFilter_Click" />

                                <asp:Button ID="btnLinux" runat="server"
                                    CssClass="btn btn-outline-primary"
                                    Text="Linux"
                                    CommandArgument="Linux"
                                    OnClick="btnFilter_Click" />

                                <asp:Button ID="btnWindows" runat="server"
                                    CssClass="btn btn-outline-primary"
                                    Text="Windows"
                                    CommandArgument="Windows"
                                    OnClick="btnFilter_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Plans -->
                    <div class="row g-4">
                        <asp:Repeater ID="rptIpPlans" runat="server" OnItemCommand="rptIpPlans_ItemCommand" OnItemDataBound="rptIpPlans_ItemDataBound">
                            <ItemTemplate>
                                <div class="col-md-6 col-lg-4">
                                    <div class="pricing-card <%# Eval("IsPopular").ToString() == "True" ? "popular" : "" %>">
                                        <span class="badge-top">
                                            <%# Eval("Badge") %>
                                        </span>
                                        <div class="plan-icon"><i class="icon-server"></i></div>
                                        <h5 class="plan-title"><%# Eval("Title") %></h5>
                                        <p class="plan-desc"><%# Eval("Description") %></p>

                                        <!-- PRICE LABEL (accessible in code-behind) -->
                                        <div class="price-box">
                                            <span class="price" id="lblPrice" runat="server">₹<%# Eval("Price") %></span>
                                            <span class="period">/mo</span>
                                        </div>

                                        <p class="save-text"><%# Eval("PromoText") %></p>

                                        <div class="specs-container">
                                            <h6 class="spec-title">Features</h6>
                                            <ul class="feature-list"><%# Eval("FeaturesHtml") %></ul>
                                        </div>

                                        <div class="specs-container">
                                            <h6 class="spec-title">Select RAM</h6>
                                            <asp:DropDownList ID="ddlRamPerPlan" runat="server" CssClass="form-select"
                                                AutoPostBack="true"
                                                OnSelectedIndexChanged="ddlRamPerPlan_SelectedIndexChanged"
                                                SelectedValue='<%# Eval("Ram") %>'>
                                                <asp:ListItem Text="4 GB" Value="4" />
                                                <asp:ListItem Text="8 GB" Value="8" />
                                                <asp:ListItem Text="16 GB" Value="16" />
                                                <asp:ListItem Text="32 GB" Value="32" />
                                            </asp:DropDownList>

                                        </div>

                                        <!-- HIDDEN PLAN ID -->
                                        <asp:HiddenField ID="hdnPlanId" runat="server" Value='<%# Eval("Id") %>' />
                                        <asp:HiddenField ID="hdnIpv4" runat="server" Value='<%# Eval("Ipv4") %>' />

                                        <asp:Button ID="btnBuyNow" runat="server"
                                            Text="Buy Now"
                                            CssClass="btn btn-primary w-100 mt-2"
                                            CommandName="BuyNow"
                                            CommandArgument='<%# Eval("Id") %>' />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtSearch" EventName="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnAll" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnLinux" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnWindows" EventName="Click" />

                </Triggers>
            </asp:UpdatePanel>
              
            <!-- HostDzire Offers (same pricing-card structure as rptIpPlans) -->
            <asp:UpdatePanel ID="UpdatePanelHostDzire" runat="server">
                <ContentTemplate>
                    <div class="row g-4">
                        <asp:Repeater ID="rptHostDzire" runat="server" OnItemDataBound="rptHostDzire_ItemDataBound">
                            <ItemTemplate>
                                <div class="col-md-6 col-lg-4">
                                    <div class="pricing-card <%# Convert.ToInt32(Eval("Qty")) > 20 ? "popular" : "" %>">
                                        <span class="badge-top">
                                            <%# (Convert.ToInt32(Eval("VPS")) >= 4) ? "<i class='icon-star-full'></i> Gold 3.0GHz" 
                                               : (Convert.ToInt32(Eval("VPS")) == 3) ? "<i class='icon-diamond1'></i> Pro AMD" : "<i class='icon-sphere'></i> Silver" %>
                                        </span>

                                        <div class="plan-icon"><i class="icon-server"></i></div>

                                        <!-- Title = IP -->
                                        <h5 class="plan-title"><%# Eval("IP") %></h5>

                                        <!-- Description -->
                                        <p class="plan-desc">
                                            IPv4 stock: <%# Eval("Qty") %> &nbsp; | &nbsp; Tier: <%# Eval("VPS") %>
                                        </p>

                                        <!-- PRICE LABEL (INR) -->
                                        <div class="price-box">
                                            <span class="price" id="lblHostPrice" runat="server">₹<%# Eval("PricePerUnit") %></span>
                                            <span class="period">/month</span>
                                        </div>
                                        <div>
                                            <span style="display:none" id="lblIN" runat="server"><%# Eval("ItemName") %></span>
                                        </div>

                                        <p class="save-text">
                                            <%# Convert.ToInt32(Eval("Qty")) > 100 ? "Bulk discount available!" : "" %>
                                        </p>

                                        <div class="specs-container">
                                            <h6 class="spec-title">Features</h6>
                                            <ul class="feature-list">
                                                <li><i class="icon-check"></i> <%# Eval("Qty") %> IPv4 addresses</li>
                                                <li><i class="icon-check"></i> Tier: <%# Eval("VPS") %></li>
                                                <li><i class="icon-check"></i> PID: <%# Eval("PID") %></li>
                                                <li><i class="icon-check"></i> Full root access</li>
                                                <li><i class="icon-check"></i> DDoS Protection</li>
                                            </ul>
                                        </div>

                                        <div class="specs-container">
                                            <h6 class="spec-title">Select RAM</h6>
                                           <asp:DropDownList 
    ID="ddlHostRam"
    runat="server"
    CssClass="form-select"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlHostRam_SelectedIndexChanged"
    CommandArgument='<%# Eval("IP") %>'>
    <asp:ListItem Selected="True" Text="4 GB" Value="4" />
    <asp:ListItem Text="8 GB" Value="8" />
    <asp:ListItem Text="16 GB" Value="16" />
    <asp:ListItem Text="32 GB" Value="32" />
    <asp:ListItem Text="64 GB" Value="64" />
</asp:DropDownList>
                                        </div>

                                        <asp:HiddenField ID="hdnHostPID" runat="server" Value='<%# Eval("PID") %>' />
                                        <asp:HiddenField ID="hdnHostVPS" runat="server" Value='<%# Eval("VPS") %>' />
                                        <asp:HiddenField ID="hdnHostQty" runat="server" Value='<%# Eval("Qty") %>' />
<asp:HiddenField ID="hdnIP" runat="server" Value='<%# Eval("IP") %>' />
<asp:HiddenField ID="hdnItemName" runat="server" Value='<%# Eval("ItemName") %>' />
Total Price
<span id="lblPrice" runat="server" class="fw-bold text-success">
    ₹<%# Eval("PricePerUnit") %>
</span>
                                        <asp:Button ID="btnHostBuyNow" runat="server"
                                            Text="Buy Now"
                                            CssClass="btn btn-primary w-100 mt-2"
                                            OnClick="btnHostBuyNow_Click"
                                            CommandArgument='<%# Eval("IP") %>' />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <asp:Panel ID="pnlNoHostDzire" runat="server" Visible="false" CssClass="mt-3">
                        <div class="alert alert-dark text-center shadow-sm">
                            ℹ️ No offers available.
                        </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </section>

    <style>
        .badge-top {
            display: inline-block;
            font-size: 1rem;
            font-weight: bold;
            padding: 6px 12px;
            border-radius: 12px;
            background: #222;
            color: #fff;
            margin-bottom: 8px;
        }
        .badge-top i { margin-right: 6px; font-size: 1.2rem; }

        /* Keep your darkstar / gradient look — adjust if needed */
        .pricing-card { background:#0f0f10; border-radius:14px; padding:22px; border:1px solid rgba(128,71,255,0.08); box-shadow:0 8px 40px rgba(0,0,0,0.6); }
        .pricing-card.popular { box-shadow:0 12px 50px rgba(128,71,255,0.25); border-color:rgba(128,71,255,0.35); }
        .plan-title { color:#fff; font-weight:700; margin-top:16px; }
        .plan-desc { color:#9b9b9b; margin-bottom:8px; }
        .price-box .price { font-size:30px; font-weight:800; color:#8a3cff; display:block; }
        .specs-container { margin-top:16px; background:rgba(255,255,255,0.02); padding:12px; border-radius:8px; }
        .feature-list { list-style:none; padding:0; margin:0; color:#cfcfcf; }
        .feature-list li { padding:10px 0; border-bottom:1px solid rgba(255,255,255,0.02); }
    </style>
</asp:Content>
