<%@ Page Title="24/7 Support" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="support.aspx.cs" Inherits="Pages_support" %>

	<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!-- Portfolio Section
				================================================== -->
	<section id="support" class="section light-bg text-dark">
  <div class="container">

    <!-- AI Assistant Section -->
    <div class="row text-center mb-5">
      <div class="col">
        <h2 class="section-title">Get Instant Help with <span class="gradient-text">Our Assistant</span></h2>
        <p class="section-subtitle">
          Ask anything about our Linux hosting services, pricing, or technical questions.  
          Our assistant is trained on all <strong>OceanLinux</strong> services and ready to help <strong>24/7</strong>.
        </p>
      </div>
    </div>

    <div class="row d-flex align-items-stretch">
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-clock fa-2x mb-3 text-primary"></i>
          <h5>24/7</h5>
          <p>Always Available</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-bolt fa-2x mb-3 text-success"></i>
          <h5>Instant</h5>
          <p>Response Time</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-robot fa-2x mb-3 text-warning"></i>
          <h5>Smart</h5>
          <p>AI Powered</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-microchip fa-2x mb-3 text-danger"></i>
          <h5>AI Powered by</h5>
          <p>Backtick Labs</p>
        </div>
      </div>
    </div>

    <!-- Support Promise -->
    <div class="row text-center mt-5">
      <div class="col">
        <h2 class="section-title">Our <span class="gradient-text">Support Promise</span></h2>
        <p class="section-subtitle">
          We promise to provide helpful, knowledgeable support that actually solves your problems.  
          If you're not satisfied with our support, we'll make it right or refund your money.
        </p>
      </div>
    </div>

    <div class="row mt-4">
      <div class="col-md-4 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-comments fa-2x mb-3 text-info"></i>
          <h5>💬 Live Chat</h5>
          <p>Instant answers from our team</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-envelope fa-2x mb-3 text-primary"></i>
          <h5>📧 Email Support</h5>
          <p>Detailed responses for technical issues</p>
        </div>
      </div>
      <div class="col-md-4 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <i class="fas fa-phone fa-2x mb-3 text-success"></i>
          <h5>📞 Phone Support</h5>
          <p>Talk directly with our experts 24/7</p>
        </div>
      </div>
    </div>

    <!-- Customer Satisfaction -->
    <div class="row text-center mt-5">
      <div class="col">
        <h2 class="section-title">Support That <span class="gradient-text">Actually Helps</span></h2>
        <p class="section-subtitle">Our support team doesn't just answer tickets – they solve problems. Here’s why customers love us:</p>
      </div>
    </div>

    <div class="row d-flex align-items-stretch mt-4">
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <h3 class="gradient-text">&lt;2 min</h3>
          <p>Average Response Time</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <h3 class="gradient-text">98%</h3>
          <p>Customer Satisfaction</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <h3 class="gradient-text">99.5%</h3>
          <p>First Contact Resolution</p>
        </div>
      </div>
      <div class="col-md-3 col-6 mb-4">
        <div class="support-card text-center p-4 h-100 shadow-sm rounded">
          <h3 class="gradient-text">24/7/365</h3>
          <p>Support Availability</p>
        </div>
      </div>
    </div>

  </div>
</section>

        
<style>
/* --- Enhanced DarkStar pricing styles --- */
:root {
  --primary: #7c5cff;
  --secondary: #5e3dff;
  --accent1: #ff5e5e;
  --accent2: #00c27a;
  --accent3: #ffaa00;
  --dark: #121212;
  --darker: #0a0a0a;
  --light: #f8f9fa;
  --gray: #6c757d;
}

.section {
  padding: 5rem 0;
  background: linear-gradient(135deg, var(--darker) 0%, var(--dark) 100%);
  position: relative;
  overflow: hidden;
}
.section:hover::before {
  filter: brightness(1.2) drop-shadow(0 0 25px rgba(124, 92, 255, 0.4));
}

/* Optional: gradient borders on support cards */
.support-card {
  position: relative;
  background: rgba(20, 20, 20, 0.9);
  border-radius: 16px;
  overflow: hidden;
  z-index: 1;
}

.support-card::before {
  content: '';
  position: absolute;
  inset: 0;
  padding: 2px; /* border thickness */
  border-radius: 16px;
  background: linear-gradient(90deg, var(--primary), var(--secondary));
  -webkit-mask: 
    linear-gradient(#fff 0 0) content-box, 
    linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
          mask-composite: exclude;
  pointer-events: none;
  z-index: -1;
}

.support-card:hover::before {
  filter: brightness(1.3);
}
.section::before {
  content: '';
  position: absolute;
  top: -3px;
  left: -3px;
  right: -3px;
  bottom: -3px;
  border-radius: 22px;
  background: linear-gradient(90deg, var(--primary), var(--secondary), var(--accent2));
  z-index: -1;
}

.section-title {
  font-size: 2.5rem;
  font-weight: 800;
  margin-bottom: 1rem;
  position: relative;
  display: inline-block;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 4px;
  background: linear-gradient(90deg, var(--primary), var(--secondary));
  border-radius: 2px;
}

.gradient-text {
  background: linear-gradient(90deg, var(--primary), var(--secondary));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.section-subtitle {
  color: #aaa;
  max-width: 600px;
  margin: 0 auto;
  font-size: 1.1rem;
}

.pricing-card {
  background: linear-gradient(145deg, #1a1a1a 0%, #1e1e1e 100%);
  border: 1px solid #2a2a2a;
  padding: 30px;
  border-radius: 16px;
  text-align: center;
  margin-bottom: 30px;
  position: relative;
  display: flex;
  flex-direction: column;
  width: 100%;
  transition: all 0.3s ease;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

.pricing-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 5px;
  background: linear-gradient(90deg, var(--primary), var(--secondary));
  border-radius: 8px 8px 0 0;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.pricing-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
}

.pricing-card:hover::before {
  opacity: 1;
}

.pricing-card.popular {
  border: 1px solid rgba(124, 92, 255, 0.5);
  box-shadow: 0 0 25px rgba(124, 92, 255, 0.2);
}

.badge-top {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: var(--primary);
  color: #fff;
  padding: 6px 20px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  z-index: 2;
  box-shadow: 0 4px 10px rgba(124, 92, 255, 0.3);
}

.badge-top.best { 
  background: var(--accent1);
  box-shadow: 0 4px 10px rgba(255, 94, 94, 0.3);
}

.badge-top.power { 
  background: var(--accent2);
  box-shadow: 0 4px 10px rgba(0, 194, 122, 0.3);
}

.badge-top.titan { 
  background: var(--accent3);
  box-shadow: 0 4px 10px rgba(255, 170, 0, 0.3);
}

.plan-icon {
  width: 80px;
  height: 80px;
  margin: 0 auto 20px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(145deg, rgba(124, 92, 255, 0.1) 0%, rgba(94, 61, 255, 0.1) 100%);
  color: var(--primary);
  font-size: 30px;
}

.plan-title {
  font-size: 22px;
  font-weight: 700;
  margin-bottom: 15px;
  color: var(--light);
}

.plan-desc {
  font-size: 14px;
  color: #aaa;
  margin-bottom: 20px;
  line-height: 1.6;
}

.price-box {
  font-size: 32px;
  font-weight: bold;
  margin: 20px 0 5px;
}

.old-price {
  text-decoration: line-through;
  color: var(--gray);
  margin-right: 10px;
  font-size: 18px;
}

.price {
  color: var(--primary);
  font-size: 42px;
  font-weight: 800;
}

.period {
  font-size: 16px;
  color: #aaa;
  font-weight: normal;
}

.save-text {
  color: var(--accent2);
  font-size: 14px;
  margin: 0 0 25px;
  font-weight: 600;
}

.specs-container {
  background: rgba(42, 42, 42, 0.3);
  padding: 20px;
  border-radius: 12px;
  margin: 20px 0;
}

.spec-title {
  font-size: 14px;
  font-weight: 600;
  text-transform: uppercase;
  margin-top: 0;
  margin-bottom: 15px;
  color: #888;
  letter-spacing: 1px;
}

.spec-list, .feature-list {
  text-align: left;
  margin: 0 0 20px;
  padding: 0;
  list-style: none;
}

.spec-list li, .feature-list li {
  padding: 10px 0;
  border-bottom: 1px solid #2a2a2a;
  font-size: 14px;
  display: flex;
  align-items: center;
}

.spec-list li:last-child, .feature-list li:last-child {
  border-bottom: none;
}

.spec-list i, .feature-list i {
  margin-right: 10px;
  width: 20px;
  text-align: center;
  color: var(--primary);
}

.spec-list li:last-child i {
  color: var(--accent3);
}

.btn {
  padding: 12px 20px;
  border-radius: 8px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  transition: all 0.3s ease;
}

.btn-primary {
  background: linear-gradient(90deg, var(--primary), var(--secondary));
  border: none;
}

.btn-primary:hover {
  background: linear-gradient(90deg, var(--secondary), var(--primary));
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(124, 92, 255, 0.4);
}

.btn-outline {
  background: transparent;
  border: 2px solid var(--primary);
  color: var(--primary);
}

.btn-outline:hover {
  background: var(--primary);
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(124, 92, 255, 0.4);
}

.guarantee {
  margin-top: 15px;
  font-size: 12px;
  color: #aaa;
}

.guarantee i {
  margin-right: 5px;
}

/* Responsive adjustments */
@media (max-width: 1199.98px) {
  .pricing-card {
    padding: 25px;
  }
  
  .price {
    font-size: 36px;
  }
}

@media (max-width: 991.98px) {
  .section-title {
    font-size: 2rem;
  }
  
  .specs-container {
    padding: 15px;
  }
}

@media (max-width: 767.98px) {
  .section {
    padding: 3rem 0;
  }
  
  .pricing-card {
    margin-bottom: 40px;
  }
  
  .price {
    font-size: 32px;
  }
}
</style>
        </asp:Content>


