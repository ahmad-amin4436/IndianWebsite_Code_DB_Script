<%@ Page Title="Checkout" Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="Pages_checkout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Dark theme gradient border styles */
        .gradient-border {
            position: relative;
            background: transparent;
            border-radius: 12px;
            padding: 2px;
        }
        
        .gradient-border::before {
            content: "";
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #0d6efd, #0a58ca, #0d6efd);
            border-radius: 12px;
            z-index: -1;
        }
        
        .gradient-border-thick::before {
            top: -3px;
            left: -3px;
            right: -3px;
            bottom: -3px;
            background: linear-gradient(45deg, #0d6efd, #0a58ca, #0d6efd, #0b5ed7);
            animation: border-pulse 3s infinite alternate;
        }
        
        .gradient-card {
            background: rgba(33, 37, 41, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 25px;
            height: 100%;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            color: #f8f9fa;
        }
        
        .gradient-card:hover {
            background: rgba(33, 37, 41, 0.98);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.4);
        }
        
        .gradient-btn {
            background: linear-gradient(45deg, #0d6efd, #0a58ca);
            border: none;
            color: white;
            transition: all 0.3s ease;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .gradient-btn:hover {
            background: linear-gradient(45deg, #0a58ca, #0d6efd);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(13, 110, 253, 0.4);
            color: white;
        }
        
        .price-highlight {
            background: linear-gradient(45deg, rgba(13, 110, 253, 0.15), rgba(10, 88, 202, 0.15));
            border-radius: 12px;
            padding: 20px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .feature-item {
            border-left: 3px solid transparent;
            border-image: linear-gradient(to bottom, #0d6efd, #0a58ca);
            border-image-slice: 1;
            padding-left: 12px;
            margin-bottom: 10px;
            background: rgba(255, 255, 255, 0.05);
            padding: 10px 15px;
            border-radius: 6px;
        }
        
        .spec-item {
            background: rgba(13, 110, 253, 0.1);
            border-radius: 8px;
            padding: 10px 15px;
            margin-bottom: 10px;
            border-left: 3px solid #0d6efd;
            color: #e9ecef;
        }
        
        /* Animation for gradient borders */
        @keyframes border-pulse {
            0% {
                opacity: 0.8;
            }
            100% {
                opacity: 1;
            }
        }
        
        /* Dark theme adjustments */
        body {
            background: linear-gradient(135deg, rgba(13, 17, 23, 0.95) 0%, rgba(33, 37, 41, 0.9) 100%);
            min-height: 100vh;
            color: #f8f9fa;
        }
        
        .text-primary {
            color: #0dcaf0 !important;
        }
        
        .text-muted {
            color: #6c757d !important;
        }
        
        /* Transparent alert for dark theme */
        .alert-transparent {
            background: rgba(255, 193, 7, 0.1);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 193, 7, 0.3);
            color: #ffc107;
        }
        
        /* Icon styling for dark theme */
        .icon-circle {
            background: linear-gradient(45deg, #0d6efd, #0a58ca);
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
        }
        
        /* Border adjustments for dark theme */
        .border-top {
            border-top: 1px solid rgba(255, 255, 255, 0.1) !important;
        }
        
        /* Link styling for dark theme */
        .alert-link {
            color: #0dcaf0;
            text-decoration: underline;
        }
        
        .alert-link:hover {
            color: #0dcaf0;
            opacity: 0.8;
        }
        
        /* List styling */
        .list-unstyled li {
            color: #e9ecef;
        }
        
        /* Text success color adjustment */
        .text-success {
            color: #20c997 !important;
        }
    </style>

    <div class="container my-5">
        <div class="row">
            <!-- Product Details Column -->
            <div class="col-md-8">
                <div class="gradient-border gradient-border-thick mb-4">
                    <div class="gradient-card">
                        <h5 class="text-primary mb-3"><i class="fas fa-user me-2"></i>Customer Details</h5>

                        <div class="mb-3">
                            <asp:Label ID="lblName" runat="server" AssociatedControlID="txtName" CssClass="form-label text-light" Text="Full Name"></asp:Label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control bg-dark text-light border-0" placeholder="Enter your full name" />
                        </div>

                        <div class="mb-3">
                            <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" CssClass="form-label text-light" Text="Email Address"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-dark text-light border-0" placeholder="Enter your email" />
                        </div>

                        <div class="mb-3">
                            <asp:Label ID="lblMobile" runat="server" AssociatedControlID="txtMobile" CssClass="form-label text-light" Text="Mobile Number"></asp:Label>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control bg-dark text-light border-0" placeholder="Enter your mobile number" />
                        </div>

                        <asp:Panel ID="pnlProduct" runat="server">
                            <div class="d-flex align-items-center mb-4">
                                <div class="icon-circle me-3">
                                    <i class="fas fa-server text-white fa-2x"></i>
                                </div>
                                <div>
                                    <asp:Label ID="lblPlanTitle" runat="server" CssClass="h2 text-primary mb-1"></asp:Label>
                                    <p class="text-muted mb-0">Premium hosting solution</p>
                                </div>
                            </div>
                            
                            <div class="border-top pt-3 mb-4">
                                <p class="lead mb-0 text-light">
                                    <asp:Label ID="lblPlanDesc" runat="server"></asp:Label>
                                </p>
                            </div>

                            <h4 class="pb-2 mb-3 text-primary" style="border-bottom: 2px solid rgba(13, 110, 253, 0.3);">Server Specifications</h4>
                            <div class="ps-2">
                                <asp:Literal ID="litSpecs" runat="server"></asp:Literal>
                            </div>

                            <h4 class="pb-2 mb-3 mt-4 text-primary" style="border-bottom: 2px solid rgba(13, 110, 253, 0.3);">Features Included</h4>
                            <div class="ps-2">
                                <asp:Literal ID="litFeatures" runat="server"></asp:Literal>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlNoProduct" runat="server" Visible="false" CssClass="alert alert-transparent mt-3">
                            <strong>No product selected.</strong> Please go back to the <a href="affordable_hosting.aspx" class="alert-link">plans page</a> and choose a plan.
                        </asp:Panel>
                    </div>
                </div>
            </div>

            <!-- Pricing & Checkout Column -->
            <div class="col-md-4">
                <div class="gradient-border mb-4">
                    <div class="gradient-card">
                        <div class="price-highlight text-center mb-4">
                            <div class="mb-2">
                                <asp:Label ID="lblOldPrice" runat="server" CssClass="text-muted text-decoration-line-through h5"></asp:Label>
                            </div>
                            <div class="mb-2">
                                <asp:Label ID="lblPrice" runat="server" CssClass="h1 text-primary fw-bold"></asp:Label>
                            </div>
                            <div>
                                <asp:Label ID="lblPeriod" runat="server" CssClass="text-muted"></asp:Label>
                            </div>
                        </div>

                        <asp:Button ID="btnProceed" runat="server" CssClass="btn gradient-btn btn-lg w-100 py-3 mb-3" Text="Proceed to Payment" OnClick="btnPay_Click" />
                        <asp:HiddenField ID="hfProductId" runat="server" />
                        
                        <div class="text-center small text-muted mt-3">
                            <i class="fas fa-lock me-1"></i> Secure checkout
                        </div>
                    </div>
                </div>

                <div class="gradient-border">
                    <div class="gradient-card">
                        <h5 class="text-primary mb-3"><i class="fas fa-check-circle me-2"></i>What's Included</h5>
                        <ul class="list-unstyled">
                            <li class="feature-item"><i class="fas fa-check text-success me-2"></i>30-day money-back guarantee</li>
                            <li class="feature-item"><i class="fas fa-check text-success me-2"></i>Instant setup</li>
                            <li class="feature-item"><i class="fas fa-check text-success me-2"></i>24/7 customer support</li>
                            <li class="feature-item"><i class="fas fa-check text-success me-2"></i>Free SSL certificate</li>
                            <li class="feature-item"><i class="fas fa-check text-success me-2"></i>99.9% uptime guarantee</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

   
<!-- ✅ Checkout Helper Script -->
<script>
  function goToCheckout(options) {
    var params = new URLSearchParams();
    if (options.productId) params.set('productId', options.productId);
    if (options.title) params.set('title', options.title);
    if (options.desc) params.set('desc', options.desc);
    if (options.price) params.set('price', options.price);
    if (options.period) params.set('period', options.period);
    if (options.features) {
      if (Array.isArray(options.features)) {
        params.set('features', options.features.join('|'));
      } else {
        params.set('features', options.features);
      }
    }
    window.location.href = 'checkout.aspx?' + params.toString();
  }

  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.btn-goCheckout').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var ds = this.dataset;
        var opts = {
          productId: ds.productId || '',
          title: ds.title || '',
          desc: ds.desc || '',
          price: ds.price || '',
          period: ds.period || '',
          features: (ds.features || '').split('|').filter(Boolean)
        };
        goToCheckout(opts);
      });
    });
  });
</script>

</asp:Content>