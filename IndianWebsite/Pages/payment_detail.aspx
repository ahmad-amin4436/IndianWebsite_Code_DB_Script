<%@ Page Title="Transaction Details" Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="payment_detail.aspx.cs" Inherits="Pages_payment_detail" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Gradient Border Container */
        .gradient-border {
            position: relative;
            border-radius: 16px;
            padding: 2px; /* border thickness */
            background: linear-gradient(135deg, #6a11cb, #2575fc, #00c6ff, #0072ff);
            background-size: 400% 400%;
            animation: gradientMove 8s ease infinite;
        }

        .gradient-border-thick {
            padding: 3px; /* thicker border */
        }

        /* Inner Card */
        .gradient-card {
            background: #1e1e2f;
            border-radius: 14px;
            padding: 20px;
            color: #eaeaea;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
        }

            /* Headings */
            .gradient-card h5 {
                font-weight: 600;
                background: linear-gradient(90deg, #ff8a00, #e52e71);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

        /* Gradient animation */
        @keyframes gradientMove {
            0% {
                background-position: 0% 50%;
            }

            50% {
                background-position: 100% 50%;
            }

            100% {
                background-position: 0% 50%;
            }
        }

        /* Labels */
        .gradient-card .mb-3 strong {
            color: #aaa;
        }

        .gradient-card .text-primary {
            color: #00c6ff !important;
        }

        .gradient-card .text-success {
            color: #00ff9d !important;
        }

        .gradient-card .text-danger {
            color: #ff4d6d !important;
        }
    </style>

    <div class="container my-5">
        <div class="row">
            <div class="col-md-8">
                <!-- Transaction Card -->
                <div class="gradient-border gradient-border-thick mb-4">
                    <div class="gradient-card">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-file-invoice-dollar me-2"></i>Transaction Details
                        </h5>

                        <asp:Panel ID="pnlTransaction" runat="server">
                            <div class="mb-3">
                                <strong>Client Txn ID:</strong>
                                <asp:Label ID="lblClientTxnId" runat="server" CssClass="text-light ms-2"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Customer:</strong>
                                <asp:Label ID="lblCustomer" runat="server" CssClass="text-light ms-2"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Email:</strong>
                                <asp:Label ID="lblEmail" runat="server" CssClass="text-light ms-2"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Mobile:</strong>
                                <asp:Label ID="lblMobile" runat="server" CssClass="text-light ms-2"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Amount:</strong>
                                <asp:Label ID="lblAmount" runat="server" CssClass="text-primary ms-2 fw-bold"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Status:</strong>
                                <asp:Label ID="lblStatus" runat="server" CssClass="text-success ms-2 fw-bold"></asp:Label>
                            </div>
                            <div class="mb-3">
                                <strong>Date:</strong>
                                <asp:Label ID="lblDate" runat="server" CssClass="text-light ms-2"></asp:Label>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlNoRecord" runat="server" Visible="false" CssClass="alert alert-transparent mt-3">
                            <strong>No transaction found.</strong> Please check your 
                            <a href="transactions_list.aspx" class="alert-link">transactions</a>.
                        </asp:Panel>
                    </div>
                </div>

                <!-- VPS Status Card -->
                <div class="gradient-border gradient-border-thick">
                    <div class="gradient-card">
                        <h5 class="text-primary mb-3">
                            <i class="fas fa-server me-2"></i>VPS Status
                        </h5>

                        <div class="mb-3">
                            <strong>Order Status:</strong>
                            <asp:Label ID="lblVpsStatus" runat="server" CssClass="text-success ms-2 fw-bold"></asp:Label>
                        </div>

                        <div class="mb-3">
                            <strong>Details:</strong>
                            <asp:Label ID="lblVpsDetails" runat="server" CssClass="text-light ms-2"></asp:Label>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
