<%@ Page Title="My Account" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Portal_Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .account-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 20px;
            margin-top: 20px;
        }
        .account-sidebar {
            background: #1e1e1e;
            border-radius: 12px;
            padding: 20px;
            color: #fff;
        }
        .account-sidebar h3 {
            font-size: 18px;
            margin-bottom: 15px;
        }
        .account-sidebar ul {
            list-style: none;
            padding: 0;
        }
        .account-sidebar ul li {
            margin: 10px 0;
        }
        .account-sidebar ul li a {
            color: #bbb;
            text-decoration: none;
            display: block;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
        }
        .account-sidebar ul li a.active,
        .account-sidebar ul li a:hover {
            background: #00bfff;
            color: #fff;
        }
        .account-content {
            background: #1e1e1e;
            border-radius: 12px;
            padding: 25px;
            color: #fff;
        }
        .section-header {
            font-size: 20px;
            margin-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            padding-bottom: 8px;
        }
        .info-grid {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: bold;
            color: #bbb;
        }
        .form-group { margin-bottom: 15px; }
        .form-label { display: block; margin-bottom: 6px; color: #bbb; }
        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: none;
            outline: none;
        }
        .btn-primary {
            background: #00bfff; color: #fff;
            border: none; padding: 10px 20px;
            border-radius: 6px; cursor: pointer;
        }
        .btn-primary:hover { background: #009acd; }
        .btn-secondary {
            background: #444; color: #fff;
            border: none; padding: 10px 20px;
            border-radius: 6px; cursor: pointer;
            margin-left: 10px;
        }
        .btn-secondary:hover { background: #666; }
        .danger-zone {
            margin-top: 30px;
            padding: 20px;
            background: #2a0000;
            border-radius: 8px;
        }
        .danger-zone h4 { color: #ff4444; }
        .btn-danger {
            background: #ff4444; color: #fff;
            border: none; padding: 10px 20px;
            border-radius: 6px; cursor: pointer;
        }
        .btn-danger:hover { background: #cc0000; }
        .security-tip {
            margin-top: 20px;
            font-size: 14px;
            color: #bbb;
            background: #2a2a2a;
            padding: 10px;
            border-radius: 6px;
        }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
    </style>

    <div class="container">
        <h2 style="color:white;">My Account</h2>
        <p style="color:#bbb;">Manage your profile and account settings</p>

        <div class="account-container">
            <!-- Sidebar -->
            <div class="account-sidebar">
                <h3>Menu</h3>
                <ul>
                    <li><a class="tab-link active" data-tab="profile">Profile</a></li>
                    <li><a class="tab-link" data-tab="security">Security</a></li>
                </ul>
            </div>

            <!-- Content -->
            <div class="account-content">
                <!-- Profile Tab -->
                <div id="profile" class="tab-content active">
                    <div class="section-header">Personal Information</div>
                    <div class="info-grid">
                        <div class="info-label">Full Name</div>
                        <div class="info-value"><asp:Label ID="lblFullName" runat="server" /></div>

                        <div class="info-label">Email Address</div>
                        <div class="info-value"><asp:Label ID="lblEmail" runat="server" /></div>

                        <div class="info-label">Member Since</div>
                        <div class="info-value"><asp:Label ID="lblCreatedDate" runat="server" /></div>
                    </div>

                    <div class="danger-zone">
                        <h4>Danger Zone</h4>
                        <p>Permanently delete your account and all associated data. This action cannot be undone.</p>
                        <asp:Button ID="btnDeleteAccount" runat="server" Text="Delete Account" CssClass="btn-danger" OnClick="btnDeleteAccount_Click" UseSubmitBehavior="false" />
                    </div>
                </div>

                <!-- Security Tab -->
                <div id="security" class="tab-content">
                    <asp:Panel runat="server" DefaultButton="btnChangePassword">
                        <div class="section-header">Security Settings</div>
                        <p style="color:#bbb;">After changing your password, you'll be automatically logged out from all devices for security reasons.</p>

                        <div class="form-group">
                            <label class="form-label">Current Password</label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>

                        <div class="form-group">
                            <label class="form-label">Confirm New Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2"></asp:Label>

                        <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn-primary" OnClick="btnChangePassword_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-secondary" />
                    </asp:Panel>

                    <div class="security-tip">
                        <strong>Security Tip:</strong> Use a unique password that you don't use for other accounts. Consider using a password manager to generate and store strong passwords.
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll(".tab-link").forEach(link => {
            link.addEventListener("click", function () {
                // remove active class from all links
                document.querySelectorAll(".tab-link").forEach(l => l.classList.remove("active"));
                this.classList.add("active");

                // hide all tab contents
                document.querySelectorAll(".tab-content").forEach(tab => tab.classList.remove("active"));

                // show clicked tab
                document.getElementById(this.dataset.tab).classList.add("active");
            });
        });
    </script>
</asp:Content>
