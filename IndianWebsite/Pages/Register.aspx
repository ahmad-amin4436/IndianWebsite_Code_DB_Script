<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Pages_Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   	
<!-- Register Section -->
<section id="register" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Create <span class="gradient-text">Account</span></h2>
        <p class="section-subtitle">Join us today! Fill in your details below to register.</p>
      </div>
    </div>

    <div class="row mt-5 justify-content-center">
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-user-plus me-2"></i>Secure Registration</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-user"></i>
            </div>
            <h3 class="plan-title">New Member</h3>
            
            <!-- Registration Form -->
            <div class="specs-container mt-4">
              <div class="form-group">
                <label for="txtName" class="form-label">Full Name</label>
                <asp:TextBox ID="txtName" runat="server"
                  placeholder="Enter your full name"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtEmail" class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server"
                  placeholder="Enter your email"></asp:TextBox>
              </div>
              
              <div class="form-group mt-3">
                <label for="txtPassword" class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                   placeholder="Enter password"></asp:TextBox>
              </div>

              <div class="form-group mt-3">
                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" 
                  placeholder="Confirm password"></asp:TextBox>
              </div>
            
            </div>
          </div>

          <div class="mt-auto pt-3">
            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary btn-block" 
              Text="Create Account" OnClick="btnRegister_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2"></asp:Label>

            <div class="text-center mt-3">
              <asp:HyperLink ID="lnkLogin" runat="server" 
                CssClass="text-muted" NavigateUrl="~/Pages/login.aspx">
                Already have an account? Login
              </asp:HyperLink>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</section>
				
</asp:Content>
