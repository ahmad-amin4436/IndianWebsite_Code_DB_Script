<%@ Page Title="Add Server" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeFile="assignserver.aspx.cs" Inherits="Portal_assignserver" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<section id="assign-server" class="section dark-bg text-light">
  <div class="container">

    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Assign <span class="gradient-text">Server</span></h2>
        <p class="section-subtitle">Select a user and assign them a server to manage.</p>
      </div>
    </div>

    <div class="row mt-5 justify-content-center">
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-server me-2"></i>Server Assignment</div>

          <div class="flex-grow-1">
            <h3 class="plan-title">Assign Server to User</h3>
            <asp:Label runat="server" ID="lblResult" CssClass="" Text="" />

            <div class="specs-container mt-4">

              <!-- ✅ Searchable User Email (Select2 Enabled) -->
              <div class="form-group">
                <label for="ddlUserEmail" class="form-label">User (Email)</label>
                <asp:DropDownList ID="ddlUserEmail" runat="server" CssClass=" js-example-basic-single"></asp:DropDownList>
              </div>

              <div class="form-group mt-3">
                <label for="txtIP" class="form-label">IP Address</label>
                <asp:TextBox ID="txtIP" runat="server"  placeholder="Enter IP Address"></asp:TextBox>
              </div>
              <div class="form-group mt-3">
                <label for="txtIP" class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server"  placeholder="Enter Username"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtPassword" class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server"  placeholder="Enter Password"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtOS" class="form-label">OS</label>
                <asp:TextBox ID="txtOS" runat="server"  placeholder="Enter OS"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtMemory" class="form-label">RAM</label>
                <asp:TextBox ID="txtMemory" runat="server"  placeholder="Enter RAM"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtExpiry" class="form-label">Expiry DateTime</label>
                <asp:TextBox ID="txtExpiry" runat="server"  placeholder="Enter Expiry DateTime" TextMode="DateTimeLocal"></asp:TextBox>
              </div>
            </div>
          </div>

          <div class="mt-auto pt-3">
            <asp:Button ID="btnAssign" runat="server" CssClass="btn btn-primary btn-block" Text="Assign Server" OnClick="btnAssign_Click" />
          </div>

        </div>
      </div>
    </div>
  </div>
</section>

<!-- ✅ Select2 Scripts -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
  $(document).ready(function () {
      $('#<%= ddlUserEmail.ClientID %>').select2({
          placeholder: "Select a user...",
          allowClear: true,
          width: '100%'
      });
  });
</script>
</asp:Content>
