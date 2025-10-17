<%@ Page Title="Server Series" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="server_series.aspx.cs" Inherits="Pages_server_series" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   	
<section id="pricing" class="section dark-bg text-light">
  <div class="container">

    <!-- Section Title -->
    <div class="row text-center">
      <div class="col">
        <h2 class="section-title">Our <span class="gradient-text">Server Series</span></h2>
        <p class="section-subtitle">Each series is specifically designed and optimized for different use cases and performance requirements.</p>
      </div>
    </div>

    <div class="row mt-5 d-flex align-items-stretch">

      <!-- ⭐ Gold Series Rotating -->
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top gold"><i class="fas fa-sync-alt me-2"></i>Smart Rotation</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-random"></i>
            </div>
            <h3 class="plan-title">Gold Series Rotating</h3>
            <p class="plan-desc">
              Perfect for applications with varying resource needs. Our intelligent rotation system ensures optimal performance while keeping costs low.
            </p>

            <div class="price-box">
              <span class="price">₹299</span>
              <span class="period">/month</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Features Included</h4>
              <ul class="feature-list">
                <li><i class="fas fa-sync"></i> Dynamic Resource Allocation</li>
                <li><i class="fas fa-balance-scale"></i> Intelligent Load Balancing</li>
                <li><i class="fas fa-expand-arrows-alt"></i> Auto-Scaling Capabilities</li>
                <li><i class="fas fa-coins"></i> Cost-Optimized Performance</li>
                <li><i class="fas fa-clock"></i> 24/7 Automated Monitoring</li>
              </ul>
            </div>
            <p class="ideal">Ideal for: <strong>Variable Workloads</strong></p>
          </div>

          <div class="mt-auto">
              <a href="login?productId=gold
              &title=Gold+Series+Rotating
              &desc=Perfect+for+applications+with+varying+resource+needs.+Our+intelligent+rotation+system+ensures+optimal+performance+while+keeping+costs+low.
              &price=299
              &period=%2Fmonth
              &features=Dynamic+Resource+Allocation%7CIntelligent+Load+Balancing%7CAuto-Scaling+Capabilities%7CCost-Optimized+Performance%7C24%2F7+Automated+Monitoring"
                 class="btn btn-outline btn-block">
                <i class="fas fa-clipboard-list me-2"></i> View Plans
              </a>

          </div>
        </div>
      </div>

      <!-- 🚀 Nova Linux VPS -->
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card popular d-flex flex-column">
          <div class="badge-top"><i class="fas fa-crown me-2"></i>Most Popular</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-tachometer-alt"></i>
            </div>
            <h3 class="plan-title">Nova Linux VPS</h3>
            <p class="plan-desc">
              Our flagship VPS series with cutting-edge technology and blazing-fast performance. Built for modern applications that demand speed.
            </p>

            <div class="price-box">
              <span class="price">₹599</span>
              <span class="period">/month</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Features Included</h4>
              <ul class="feature-list">
                <li><i class="fas fa-microchip"></i> Latest Intel Xeon CPUs</li>
                <li><i class="fas fa-hdd"></i> NVMe SSD Storage</li>
                <li><i class="fas fa-memory"></i> DDR4 ECC Memory</li>
                <li><i class="fas fa-network-wired"></i> 1Gbps Network Port</li>
                <li><i class="fas fa-shield-alt"></i> Advanced Security Features</li>
              </ul>
            </div>
            <p class="ideal">Ideal for: <strong>High-Performance Apps</strong></p>
          </div>

          <div class="mt-auto">
              <a href="login?productId=nova
              &title=Nova+Linux+VPS
              &desc=Our+flagship+VPS+series+with+cutting-edge+technology+and+blazing-fast+performance.+Built+for+modern+applications+that+demand+speed.
              &price=599
              &period=%2Fmonth
              &features=Latest+Intel+Xeon+CPUs%7CNVMe+SSD+Storage%7CDDR4+ECC+Memory%7C1Gbps+Network+Port%7CAdvanced+Security+Features"
                 class="btn btn-primary btn-block">
                <i class="fas fa-rocket me-2"></i> View Plans
              </a>
            </div>
        </div>
      </div>

      <!-- 🔋 Power Linux VPS -->
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top power"><i class="fas fa-battery-full me-2"></i>Maximum Performance</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-server"></i>
            </div>
            <h3 class="plan-title">Power Linux VPS</h3>
            <p class="plan-desc">
              Unleash the full potential with our most powerful VPS series. Designed for resource-intensive applications and high-traffic websites.
            </p>

            <div class="price-box">
              <span class="price">₹999</span>
              <span class="period">/month</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Features Included</h4>
              <ul class="feature-list">
                <li><i class="fas fa-bolt"></i> High-Frequency CPUs</li>
                <li><i class="fas fa-memory"></i> Maximum RAM Allocation</li>
                <li><i class="fas fa-hdd"></i> Premium NVMe Storage</li>
                <li><i class="fas fa-network-wired"></i> Dedicated Network Resources</li>
                <li><i class="fas fa-headset"></i> Priority Technical Support</li>
              </ul>
            </div>
            <p class="ideal">Ideal for: <strong>Enterprise Applications</strong></p>
          </div>

          <div class="mt-auto">
              <a href="login?productId=power
              &title=Power+Linux+VPS
              &desc=Unleash+the+full+potential+with+our+most+powerful+VPS+series.+Designed+for+resource-intensive+applications+and+high-traffic+websites.
              &price=999
              &period=%2Fmonth
              &features=High-Frequency+CPUs%7CMaximum+RAM+Allocation%7CPremium+NVMe+Storage%7CDedicated+Network+Resources%7CPriority+Technical+Support"
                 class="btn btn-outline btn-block">
                <i class="fas fa-clipboard-list me-2"></i> View Plans
              </a>
            </div>
        </div>
      </div>

      <!-- 🔰 Titan Series -->
      <div class="col-md-6 col-xl-6 d-flex mb-4">
        <div class="pricing-card d-flex flex-column">
          <div class="badge-top titan"><i class="fas fa-building me-2"></i>Enterprise Excellence</div>
          <div class="flex-grow-1">
            <div class="plan-icon">
              <i class="fas fa-crown"></i>
            </div>
            <h3 class="plan-title">Titan Series</h3>
            <p class="plan-desc">
              Our premium enterprise-grade series with dedicated resources and white-glove support. The ultimate hosting solution for mission-critical applications.
            </p>

            <div class="price-box">
              <span class="price">₹1999</span>
              <span class="period">/month</span>
            </div>

            <div class="specs-container">
              <h4 class="spec-title">Features Included</h4>
              <ul class="feature-list">
                <li><i class="fas fa-microchip"></i> Dedicated CPU Cores</li>
                <li><i class="fas fa-hdd"></i> Guaranteed Resources</li>
                <li><i class="fas fa-database"></i> Enterprise SSD Arrays</li>
                <li><i class="fas fa-network-wired"></i> Private Network Access</li>
                <li><i class="fas fa-phone"></i> 24/7 Phone Support</li>
              </ul>
            </div>
            <p class="ideal">Ideal for: <strong>Mission-Critical Systems</strong></p>
          </div>

         <div class="mt-auto">
              <a href="login?productId=titan
              &title=Titan+Series
              &desc=Our+premium+enterprise-grade+series+with+dedicated+resources+and+white-glove+support.+The+ultimate+hosting+solution+for+mission-critical+applications.
              &price=1999
              &period=%2Fmonth
              &features=Dedicated+CPU+Cores%7CGuaranteed+Resources%7CEnterprise+SSD+Arrays%7CPrivate+Network+Access%7C24%2F7+Phone+Support"
                 class="btn btn-outline btn-block">
                <i class="fas fa-clipboard-list me-2"></i> View Plans
              </a>
            </div>
        </div>
      </div>

    </div>

  

  </div>
</section>
    <section id="pricing2" class="section dark-bg text-light">
        <div class="container">

            <!-- Section Title -->
            <div class="row text-center">
                <div class="col">
                    <h2 class="section-title">Our <span class="gradient-text">Hosting Plans</span></h2>
                    <p class="section-subtitle">Choose the perfect solution for your needs. All plans include our 30-day money-back guarantee</p>
                </div>
            </div>

            <div class="row mt-5 d-flex align-items-stretch">

                <!-- ⭐ Premium Gold Series -->
                <div class="col-md-6 col-xl-6 d-flex mb-4">
                    <div class="pricing-card popular d-flex flex-column">
                        <div class="badge-top"><i class="fas fa-crown me-2"></i>Most Popular</div>
                        <div class="flex-grow-1">
                            <div class="plan-icon">
                                <i class="fas fa-sync-alt"></i>
                            </div>
                            <h3 class="plan-title">Premium Gold Series</h3>
                            <p class="plan-desc">
                                Premium rotating Linux servers with high-quality IP ranges. Perfect for businesses needing reliable, rotating IP solutions at affordable prices.
                            </p>

                            <div class="price-box">
                                <span class="old-price">₹999</span>
                                <span class="price">₹599</span>
                                <span class="period">/month</span>
                            </div>
                            <div class="save-text">Save ₹400 per month</div>

                            <div class="specs-container">
                                <h4 class="spec-title">Server Specifications</h4>
                                <ul class="spec-list">
                                    <li><i class="fas fa-microchip"></i><strong>CPU:</strong> 4 vCPU Cores</li>
                                    <li><i class="fas fa-memory"></i><strong>RAM:</strong> 8GB DDR4 RAM</li>
                                    <li><i class="fas fa-hdd"></i><strong>Storage:</strong> 100GB NVMe SSD</li>
                                    <li><i class="fas fa-network-wired"></i><strong>Bandwidth:</strong> Unlimited</li>
                                    <li><i class="fas fa-globe"></i><small>IP Range: 103.183.xx • 103.187.xx</small></li>
                                </ul>

                                <h4 class="spec-title">Features Included</h4>
                                <ul class="feature-list">
                                    <li><i class="fas fa-sync"></i>Premium rotating IP addresses</li>
                                    <li><i class="fas fa-tachometer-alt"></i>High-speed NVMe SSD storage</li>
                                    <li><i class="fas fa-shield-alt"></i>Advanced DDoS protection</li>
                                    <li><i class="fas fa-lock"></i>Enterprise-grade security</li>
                                    <li><i class="fas fa-headset"></i>24/7 email &amp; chat support</li>
                                    <li><i class="fas fa-cogs"></i>Full root access &amp; control</li>
                                    <li><i class="fas fa-plus-circle"></i>+4 more features included</li>
                                </ul>
                            </div>
                        </div>

                        <div class="mt-auto">
                            <!-- Wired button -->
                            <a href="login"
                                class="btn btn-primary btn-block btn-goCheckout"
                                data-product-id="gold"
                                data-title="Premium Gold Series"
                                data-desc="Premium rotating Linux servers with high-quality IP ranges."
                                data-price="599"
                                data-oldprice="999"
                                data-period="/month"
                                data-cpu="4 vCPU Cores"
                                data-ram="8GB DDR4 RAM"
                                data-storage="100GB NVMe SSD"
                                data-bandwidth="Unlimited"
                                data-iprange="103.183.xx • 103.187.xx"
                                data-features="Premium rotating IP addresses|High-speed NVMe SSD storage|Advanced DDoS protection|Enterprise-grade security|24/7 email &amp; chat support|Full root access &amp; control">
                                <i class="fas fa-rocket me-2"></i>Get Started Now
                            </a>
                            <p class="guarantee"><i class="fas fa-money-bill-wave"></i>30-day money-back guarantee • <i class="fas fa-bolt"></i>Instant setup</p>
                        </div>
                    </div>
                </div>

                <!-- 🚀 Nova Linux VPS -->
                <div class="col-md-6 col-xl-6 d-flex mb-4">
                    <div class="pricing-card d-flex flex-column">
                        <div class="badge-top best"><i class="fas fa-bolt me-2"></i>Best Performance</div>
                        <div class="flex-grow-1">
                            <div class="plan-icon">
                                <i class="fas fa-tachometer-alt"></i>
                            </div>
                            <h3 class="plan-title">Nova Linux VPS</h3>
                            <p class="plan-desc">
                                High-performance Linux VPS servers designed for speed and reliability. Get premium performance at the most affordable prices in the market.
                            </p>

                            <div class="price-box">
                                <span class="old-price">₹1,299</span>
                                <span class="price">₹799</span>
                                <span class="period">/month</span>
                            </div>
                            <div class="save-text">Save ₹500 per month</div>

                            <div class="specs-container">
                                <h4 class="spec-title">Server Specifications</h4>
                                <ul class="spec-list">
                                    <li><i class="fas fa-microchip"></i><strong>CPU:</strong> 6 vCPU Cores</li>
                                    <li><i class="fas fa-memory"></i><strong>RAM:</strong> 12GB DDR4 RAM</li>
                                    <li><i class="fas fa-hdd"></i><strong>Storage:</strong> 150GB NVMe SSD</li>
                                    <li><i class="fas fa-network-wired"></i><strong>Bandwidth:</strong> Unlimited</li>
                                    <li><i class="fas fa-globe"></i><small>IP Range: 163.227.xx</small></li>
                                </ul>

                                <h4 class="spec-title">Features Included</h4>
                                <ul class="feature-list">
                                    <li><i class="fas fa-star"></i>Optimized for high performance</li>
                                    <li><i class="fas fa-tachometer-alt"></i>Ultra-fast NVMe SSD storage</li>
                                    <li><i class="fas fa-microchip"></i>Enhanced CPU performance</li>
                                    <li><i class="fas fa-shield-alt"></i>Multi-layer security protection</li>
                                    <li><i class="fas fa-sliders-h"></i>Advanced control panel</li>
                                    <li><i class="fas fa-wrench"></i>One-click app installations</li>
                                    <li><i class="fas fa-plus-circle"></i>+4 more features included</li>
                                </ul>
                            </div>
                        </div>

                        <div class="mt-auto">
                            <!-- Wired button -->
                            <a href="login"
                                class="btn btn-outline btn-block btn-goCheckout"
                                data-product-id="nova"
                                data-title="Nova Linux VPS"
                                data-desc="High-performance Linux VPS servers designed for speed and reliability."
                                data-price="799"
                                data-oldprice="1299"
                                data-period="/month"
                                data-cpu="6 vCPU Cores"
                                data-ram="12GB DDR4 RAM"
                                data-storage="150GB NVMe SSD"
                                data-bandwidth="Unlimited"
                                data-iprange="163.227.xx"
                                data-features="Optimized for high performance|Ultra-fast NVMe SSD storage|Enhanced CPU performance|Multi-layer security protection|Advanced control panel|One-click app installations">
                                <i class="fas fa-clipboard-list me-2"></i>Choose This Plan
                            </a>
                            <p class="guarantee"><i class="fas fa-money-bill-wave"></i>30-day money-back guarantee • <i class="fas fa-bolt"></i>Instant setup</p>
                        </div>
                    </div>
                </div>

                <!-- 🔋 Power Linux VPS -->
                <div class="col-md-6 col-xl-6 d-flex mb-4">
                    <div class="pricing-card d-flex flex-column">
                        <div class="badge-top power"><i class="fas fa-battery-full me-2"></i>Maximum Power</div>
                        <div class="flex-grow-1">
                            <div class="plan-icon">
                                <i class="fas fa-server"></i>
                            </div>
                            <h3 class="plan-title">Power Linux VPS</h3>
                            <p class="plan-desc">
                                Maximum power and control for demanding applications. Enterprise-grade Linux hosting at budget-friendly prices with premium features included.
                            </p>

                            <div class="price-box">
                                <span class="old-price">₹1,499</span>
                                <span class="price">₹899</span>
                                <span class="period">/month</span>
                            </div>
                            <div class="save-text">Save ₹600 per month</div>

                            <div class="specs-container">
                                <h4 class="spec-title">Server Specifications</h4>
                                <ul class="spec-list">
                                    <li><i class="fas fa-microchip"></i><strong>CPU:</strong> 8 vCPU Cores</li>
                                    <li><i class="fas fa-memory"></i><strong>RAM:</strong> 16GB DDR4 RAM</li>
                                    <li><i class="fas fa-hdd"></i><strong>Storage:</strong> 200GB NVMe SSD</li>
                                    <li><i class="fas fa-network-wired"></i><strong>Bandwidth:</strong> Unlimited</li>
                                    <li><i class="fas fa-globe"></i><small>IP Range: 149.13.xx</small></li>
                                </ul>

                                <h4 class="spec-title">Features Included</h4>
                                <ul class="feature-list">
                                    <li><i class="fas fa-bolt"></i>Maximum processing power</li>
                                    <li><i class="fas fa-hdd"></i>Premium NVMe SSD performance</li>
                                    <li><i class="fas fa-wifi"></i>High-speed network connectivity</li>
                                    <li><i class="fas fa-user-shield"></i>Advanced security suite</li>
                                    <li><i class="fas fa-headset"></i>Priority support access</li>
                                    <li><i class="fas fa-cog"></i>Advanced server management</li>
                                    <li><i class="fas fa-plus-circle"></i>+4 more features included</li>
                                </ul>
                            </div>
                        </div>

                        <div class="mt-auto">
                            <!-- Wired button -->
                            <a href="login"
                                class="btn btn-outline btn-block btn-goCheckout"
                                data-product-id="power"
                                data-title="Power Linux VPS"
                                data-desc="Maximum power and control for demanding applications."
                                data-price="899"
                                data-oldprice="1499"
                                data-period="/month"
                                data-cpu="8 vCPU Cores"
                                data-ram="16GB DDR4 RAM"
                                data-storage="200GB NVMe SSD"
                                data-bandwidth="Unlimited"
                                data-iprange="149.13.xx"
                                data-features="Maximum processing power|Premium NVMe SSD performance|High-speed network connectivity|Advanced security suite|Priority support access|Advanced server management">
                                <i class="fas fa-clipboard-list me-2"></i>Choose This Plan
                            </a>
                            <p class="guarantee"><i class="fas fa-money-bill-wave"></i>30-day money-back guarantee • <i class="fas fa-bolt"></i>Instant setup</p>
                        </div>
                    </div>
                </div>

                <!-- 🔰 Titan Series Enterprise -->
                <div class="col-md-6 col-xl-6 d-flex mb-4">
                    <div class="pricing-card d-flex flex-column">
                        <div class="badge-top titan"><i class="fas fa-building me-2"></i>Enterprise</div>
                        <div class="flex-grow-1">
                            <div class="plan-icon">
                                <i class="fas fa-crown"></i>
                            </div>
                            <h3 class="plan-title">Titan Series Enterprise</h3>
                            <p class="plan-desc">
                                Our flagship enterprise Linux hosting solution. Premium hardware, advanced features, and dedicated support for mission-critical applications.
                            </p>

                            <div class="price-box">
                                <span class="old-price">₹1,999</span>
                                <span class="price">₹1,299</span>
                                <span class="period">/month</span>
                            </div>
                            <div class="save-text">Save ₹700 per month</div>

                            <div class="specs-container">
                                <h4 class="spec-title">Server Specifications</h4>
                                <ul class="spec-list">
                                    <li><i class="fas fa-microchip"></i><strong>CPU:</strong> 12 vCPU Cores</li>
                                    <li><i class="fas fa-memory"></i><strong>RAM:</strong> 32GB DDR4 RAM</li>
                                    <li><i class="fas fa-hdd"></i><strong>Storage:</strong> 500GB NVMe SSD</li>
                                    <li><i class="fas fa-network-wired"></i><strong>Bandwidth:</strong> Unlimited</li>
                                    <li><i class="fas fa-globe"></i><small>IP Range: 103.15.xx</small></li>
                                </ul>

                                <h4 class="spec-title">Features Included</h4>
                                <ul class="feature-list">
                                    <li><i class="fas fa-server"></i>Enterprise-grade hardware</li>
                                    <li><i class="fas fa-tachometer-alt"></i>Flagship performance servers</li>
                                    <li><i class="fas fa-star"></i>Premium support priority</li>
                                    <li><i class="fas fa-shield-alt"></i>Maximum security features</li>
                                    <li><i class="fas fa-user-tie"></i>Dedicated account manager</li>
                                    <li><i class="fas fa-sliders-h"></i>Custom server configurations</li>
                                    <li><i class="fas fa-plus-circle"></i>+4 more features included</li>
                                </ul>
                            </div>
                        </div>

                        <div class="mt-auto">
                            <!-- Wired button -->
                            <a href="login"
                                class="btn btn-outline btn-block btn-goCheckout"
                                data-product-id="titan"
                                data-title="Titan Series Enterprise"
                                data-desc="Flagship enterprise Linux hosting solution with premium hardware and dedicated support."
                                data-price="1299"
                                data-oldprice="1999"
                                data-period="/month"
                                data-cpu="12 vCPU Cores"
                                data-ram="32GB DDR4 RAM"
                                data-storage="500GB NVMe SSD"
                                data-bandwidth="Unlimited"
                                data-iprange="103.15.xx"
                                data-features="Enterprise-grade hardware|Flagship performance servers|Premium support priority|Maximum security features|Dedicated account manager|Custom server configurations">
                                <i class="fas fa-clipboard-list me-2"></i>Choose This Plan
                            </a>
                            <p class="guarantee"><i class="fas fa-money-bill-wave"></i>30-day money-back guarantee • <i class="fas fa-bolt"></i>Instant setup</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>


</asp:Content>
