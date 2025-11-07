<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="forgotpassword.aspx.cs" Inherits="Pages_forgotpassword" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<section id="login" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Forgot Password <span class="gradient-text">Login</span></h2>
        <p class="section-subtitle">Enter your registered email to reset your password.</p>
      </div>
    </div>

    <div class="row mt-5 justify-content-center">
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-user me-2"></i>Forgot Password</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-lock"></i>
            </div>

            <!-- Step 1: Enter Email -->
            <div class="specs-container mt-4" id="emailSection" runat="server">
              <div class="form-group">
                <label for="txtEmail" class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
              </div>
              <asp:Button ID="btnSendOtp" runat="server" CssClass="btn btn-primary btn-block mt-3"
                Text="Send OTP" OnClick="btnSendOtp_Click" />
            </div>

            <!-- Step 2: Verify OTP -->
            <div class="specs-container mt-4" id="otpSection" runat="server" Visible="false">
              <div class="form-group">
                <label for="txtOtp" class="form-label">Enter OTP</label>
                <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control" placeholder="Enter OTP"></asp:TextBox>
              </div>
              <asp:Button ID="btnVerifyOtp" runat="server" CssClass="btn btn-success btn-block mt-3"
                Text="Verify OTP" OnClick="btnVerifyOtp_Click" />
            </div>

            <!-- Step 3: Change Password -->
            <div class="specs-container mt-4" id="passwordSection" runat="server" Visible="false">
              <div class="form-group">
                <label for="txtNewPassword" class="form-label">New Password</label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"
                  placeholder="Enter new password"></asp:TextBox>
              </div>
              <div class="form-group mt-2">
                <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"
                  placeholder="Confirm password"></asp:TextBox>
              </div>
              <asp:Button ID="btnChangePassword" runat="server" CssClass="btn btn-warning btn-block mt-3"
                Text="Change Password" OnClick="btnChangePassword_Click" />
            </div>

          </div>

          <div class="mt-auto pt-3">
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2"></asp:Label>

            <div class="text-center mt-3">
              <asp:HyperLink ID="lnkLogin" runat="server" CssClass="text-muted"
                NavigateUrl="~/Pages/Login.aspx">Back to Login</asp:HyperLink>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</section>

</asp:Content>
