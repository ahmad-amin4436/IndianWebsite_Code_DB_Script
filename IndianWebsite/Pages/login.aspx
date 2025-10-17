<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Pages_login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   	
<!-- Login Section
				================================================== -->
	<section id="login" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Account <span class="gradient-text">Login</span></h2>
        <p class="section-subtitle">Welcome back! Please enter your credentials to access your account.</p>
      </div>
    </div>

    <div class="row mt-5 justify-content-center">
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-user me-2"></i>Secure Login</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-lock"></i>
            </div>
            <h3 class="plan-title">Member Access</h3>
            
            <!-- Login Form -->
            <div class="specs-container mt-4">
              <div class="form-group">
                <label for="txtUsername" class="form-label">Email</label>
                <asp:TextBox ID="txtUsername" runat="server" 
                  placeholder="Enter your username"></asp:TextBox>
              </div>
              
              <div class="form-group mt-3">
                <label for="txtPassword" class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                 placeholder="Enter your password"></asp:TextBox>
              </div>
            
            </div>
          </div>

          <div class="mt-auto pt-3">
            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary btn-block" 
              Text="Login to Account" OnClick="btnLogin_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2"></asp:Label>

            <div class="text-center mt-3">
              <asp:HyperLink ID="lnkForgotPassword" runat="server" 
                CssClass="text-muted" NavigateUrl="~/Pages/Register.aspx">
                Don't have an account? Register!
              </asp:HyperLink>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Help Section -->
    

  </div>
</section>
				
</asp:Content>
