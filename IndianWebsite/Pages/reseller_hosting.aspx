<%@ Page Title="Reseller Hosting" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="reseller_hosting.aspx.cs" Inherits="Pages_reseller_hosting" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<section id="pricing" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Reseller <span class="gradient-text">Hosting Plans</span></h2>
        <p class="section-subtitle">
          Start your own hosting business without owning servers. White-label branding, client management & full support included.
        </p>
      </div>
    </div>

    <!-- Plans -->
    <div class="row mt-5 d-flex align-items-stretch">

      <!-- ⭐ Starter Reseller -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top basic"><i class="fas fa-star me-2"></i>Starter</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-people-carry"></i></div>
            <h3 class="plan-title">Starter Reseller</h3>
            <p class="plan-desc">Ideal for freelancers or small agencies having few clients.</p>

            <div class="price-box">
              <span class="price">₹499</span>
              <span class="period">/mo</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Plan Features</h4>
              <ul class="feature-list">
                <li>Disk Space: 20 GB SSD</li>
                <li>Bandwidth: 200 GB</li>
                <li>cPanel Accounts: 10</li>
                <li>Free SSL for clients</li>
                <li>WHM & Billing Tool integration</li>
              </ul>
            </div>
          </div>
          <div class="mt-auto">
            <a href="checkout.aspx?plan=reseller-starter&price=499&period=%2Fmo"
               class="btn btn-primary btn-block">
              <i class="fas fa-rocket me-2"></i> Get Started
            </a>
          </div>
        </div>
      </div>

      <!-- 🌟 Standard Reseller -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-crown me-2"></i>Most Popular</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-users"></i></div>
            <h3 class="plan-title">Standard Reseller</h3>
            <p class="plan-desc">For growing client bases with moderate resource demands.</p>

            <div class="price-box">
              <span class="price">₹999</span>
              <span class="period">/mo</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Plan Features</h4>
              <ul class="feature-list">
                <li>Disk Space: 50 GB SSD</li>
                <li>Bandwidth: 500 GB</li>
                <li>cPanel Accounts: 30</li>
                <li>Free SSL + Daily Backups</li>
                <li>White-label Branding</li>
                <li>WHM/Billing panel included</li>
              </ul>
            </div>
          </div>
          <div class="mt-auto">
            <a href="checkout.aspx?plan=reseller-standard&price=999&period=%2Fmo"
               class="btn btn-primary btn-block">
              <i class="fas fa-shopping-cart me-2"></i> Order Now
            </a>
          </div>
        </div>
      </div>

      <!-- 🔧 Pro Reseller -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top enterprise"><i class="fas fa-tools me-2"></i>Pro</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-server"></i></div>
            <h3 class="plan-title">Pro Reseller</h3>
            <p class="plan-desc">For agencies needing higher performance & more client capacity.</p>

            <div class="price-box">
              <span class="price">₹1,999</span>
              <span class="period">/mo</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Plan Features</h4>
              <ul class="feature-list">
                <li>Disk Space: 150 GB NVMe</li>
                <li>Bandwidth: Unlimited</li>
                <li>cPanel Accounts: 100+</li>
                <li>Free SSL, Daily Backups, Malware Scans</li>
                <li>White-label Branding & Custom Nameservers</li>
                <li>Priority Support 24/7</li>
              </ul>
            </div>
          </div>
          <div class="mt-auto">
            <a href="checkout.aspx?plan=reseller-pro&price=1999&period=%2Fmo"
               class="btn btn-outline btn-block">
              <i class="fas fa-shopping-cart me-2"></i> Order Now
            </a>
          </div>
        </div>
      </div>

    </div> <!-- end plans row -->

    <!-- Benefits / Why Choose Reseller Hosting -->
      <div class="row mt-5 text-center">
          <div class="col-12">
              <h3 class="section-title">Why Choose Reseller Hosting?</h3>
          </div>
      </div>

      <div class="row mt-4">
          <div class="col-md-4 text-center">
              <div class="gradient-border">
                  <i class="fas fa-handshake fa-2x mb-2"></i>
                  <h5>White-label Branding</h5>
                  <p>Run services under your own brand, with custom nameservers, logos & dashboard.</p>
              </div>
          </div>

          <div class="col-md-4 text-center">
              <div class="gradient-border">
                  <i class="fas fa-cogs fa-2x mb-2"></i>
                  <h5>Tools Included</h5>
                  <p>Billing system (WHMCS or similar), client management, easy account setup.</p>
              </div>
          </div>

          <div class="col-md-4 text-center">
              <div class="gradient-border">
                  <i class="fas fa-shield-alt fa-2x mb-2"></i>
                  <h5>Security & Support</h5>
                  <p>24/7 support, SSL, backups, and proactive monitoring to protect your clients.</p>
              </div>
          </div>
      </div>

<!-- FAQs / How It Works -->
<div class="row mt-5">
  <div class="col">
    <h4>How Reseller Hosting Works</h4>
    <p>
      With reseller hosting, you purchase server resources in bulk from us, then subdivide them into hosting accounts for your clients. You handle branding, pricing & support for your clients while we manage infrastructure, security & uptime.
    </p>
  </div>
</div>

<!-- Purple Gradient Styles -->
<style>
  .gradient-border {
    border: 3px solid transparent;
    border-radius: 12px;
    background: linear-gradient(#0d1117, #0d1117) padding-box,
                linear-gradient(135deg, #6a11cb, #a044ff) border-box; /* Purple gradient */
    padding: 20px 15px;
    margin-bottom: 20px;
    transition: all 0.3s ease;
  }

  .gradient-border:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 20px rgba(160, 68, 255, 0.6);
  }
</style>


  </div>
</section>

</asp:Content>
