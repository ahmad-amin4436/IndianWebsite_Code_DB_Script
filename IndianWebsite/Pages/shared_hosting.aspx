<%@ Page Title="Dedicated Servers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="dedicated_servers.aspx.cs" Inherits="Pages_dedicated_servers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   	
<section id="pricing" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Our <span class="gradient-text">Dedicated Servers</span></h2>
        <p class="section-subtitle">
          Deploy cloud instances with dedicated CPU, SSD drives, and RAM just for you.
          <br />Always-on, 24/7 fully-managed support • Bare metal servers with root access • Flexible server configurations
        </p>
      </div>
    </div>

    <div class="row mt-5 d-flex align-items-stretch">

      <!-- ⭐ Starter Plan -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top basic"><i class="fas fa-star me-2"></i>Starter</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-microchip"></i></div>
            <h3 class="plan-title">Starter</h3>
            <p class="plan-desc">Perfect for small-scale deployments with full control.</p>

            <div class="price-box">
              <span class="old-price">₹10,000</span>
              <span class="price">₹5,999</span>
              <span class="period">/mo</span>
            </div>
            <div class="save-text">Save 40%</div>

            <div class="specs-container">
              <h4 class="spec-title">Server Specs</h4>
              <ul class="feature-list">
                <li><i class="fas fa-microchip"></i> CPU: 8 Cores @ 2.6 Ghz V2</li>
                <li><i class="fas fa-memory"></i> RAM: 16 GB</li>
                <li><i class="fas fa-hdd"></i> Disk: 480 GB HDD</li>
                <li><i class="fas fa-network-wired"></i> Bandwidth: 1 Gbps</li>
              </ul>
            </div>
          </div>

          <div class="mt-auto">
              <a href="checkout.aspx?title=Starter&price=5999&period=%2Fmo"
                 class="btn btn-outline btn-block">
                <i class="fas fa-shopping-cart me-2"></i> Order Now
              </a>
          </div>
        </div>
      </div>

      <!-- 🚀 Standard Plan -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-crown me-2"></i>Most Popular</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-server"></i></div>
            <h3 class="plan-title">Standard</h3>
            <p class="plan-desc">Balanced power for medium to large-scale apps.</p>

            <div class="price-box">
              <span class="old-price">₹15,000</span>
              <span class="price">₹7,999</span>
              <span class="period">/mo</span>
            </div>
            <div class="save-text">Save 50%</div>

            <div class="specs-container">
              <h4 class="spec-title">Server Specs</h4>
              <ul class="feature-list">
                <li><i class="fas fa-microchip"></i> CPU: 16 Cores @ 2.6 Ghz V2</li>
                <li><i class="fas fa-memory"></i> RAM: 32 GB</li>
                <li><i class="fas fa-hdd"></i> Disk: 480 GB</li>
                <li><i class="fas fa-network-wired"></i> Bandwidth: 1 Gbps</li>
              </ul>
            </div>
          </div>

          <div class="mt-auto">
              <a href="checkout.aspx?title=Standard&price=7999&period=%2Fmo"
                 class="btn btn-primary btn-block">
                <i class="fas fa-shopping-cart me-2"></i> Order Now
              </a>
            </div>
        </div>
      </div>

      <!-- 🔋 Professional Plan -->
      <div class="col-md-4 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top enterprise"><i class="fas fa-battery-full me-2"></i>Professional</div>
          <div class="flex-grow-1">
            <div class="plan-icon"><i class="fas fa-database"></i></div>
            <h3 class="plan-title">Professional</h3>
            <p class="plan-desc">Enterprise-grade dedicated server with massive power.</p>

            <div class="price-box">
              <span class="old-price">₹19,999</span>
              <span class="price">₹9,999</span>
              <span class="period">/mo</span>
            </div>
            <div class="save-text">Save 50%</div>

            <div class="specs-container">
              <h4 class="spec-title">Server Specs</h4>
              <ul class="feature-list">
                <li><i class="fas fa-microchip"></i> CPU: 24 Cores @ 2.6 Ghz V3</li>
                <li><i class="fas fa-memory"></i> RAM: 64 GB</li>
                <li><i class="fas fa-hdd"></i> Disk: 1 TB</li>
                <li><i class="fas fa-network-wired"></i> Bandwidth: 1 Gbps</li>
              </ul>
            </div>
          </div>

          <div class="mt-auto">
              <a href="checkout.aspx?title=Professional&price=9999&period=%2Fmo"
                 class="btn btn-outline btn-block">
                <i class="fas fa-shopping-cart me-2"></i> Order Now
              </a>
            </div>
        </div>
      </div>

    </div>

    <!-- ✅ Why Choose Us Section -->
    <div class="row mt-5">
      <div class="col text-center">
        <h3 class="section-title">Included in All Hosting Plans</h3>
        <p class="section-subtitle">Powerful infrastructure, guaranteed uptime, and enterprise-grade security.</p>
      </div>
    </div>

   <style>
  /* 🔹 Custom Gradient Border */
  .gradient-border {
    border: 3px solid transparent;
    border-radius: 12px;
    background: linear-gradient(#0d1117, #0d1117) padding-box,
                linear-gradient(135deg, #001f3f, #007bff) border-box;
    padding: 20px 10px;
    transition: all 0.3s ease;
  }

  .gradient-border:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
  }
</style>

<div class="row mt-4">
  <div class="col-md-4 text-center">
    <div class="gradient-border">
      <i class="fas fa-terminal fa-2x mb-2"></i>
      <h5>Full Root & Shell Access</h5>
      <p>Total control with root access and optional control panels.</p>
    </div>
  </div>
  <div class="col-md-4 text-center">
    <div class="gradient-border">
      <i class="fas fa-signal fa-2x mb-2"></i>
      <h5>99.9% Server Uptime</h5>
      <p>Quality hardware & redundant "A" class ISP connectivity.</p>
    </div>
  </div>
  <div class="col-md-4 text-center">
    <div class="gradient-border">
      <i class="fas fa-shield-alt fa-2x mb-2"></i>
      <h5>DDoS Protection</h5>
      <p>Stay safe with proactive cyber attack monitoring & protection.</p>
    </div>
  </div>
</div>

  </div>
</section>

</asp:Content>
