<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<section id="contact" class="section dark-bg text-light">
  <div class="container">

    <!-- Title -->
    <div class="row text-center mb-5">
      <div class="col">
        <h2 class="section-title">📞 Contact <span class="gradient-text">Us</span></h2>
        <p class="section-subtitle">Our expert representatives are available to assist you.</p>
      </div>
    </div>

    <div class="row">
      <!-- Contact Info -->
      <div class="col-md-6">
        <div class="gradient-border mb-4">
          <h4><i class="fas fa-envelope me-2"></i>Email Address</h4>
          <p>
            <a href="mailto:Cosmosrecog@outlook.com" class="text-light">Cosmosrecog@outlook.com</a>
          </p>
        </div>

        <div class="gradient-border mb-4">
          <h4><i class="fas fa-phone-alt me-2"></i>Business Phone</h4>
          <p>
            <a href="tel:+917972499728" class="text-light">+91 79724 99728</a>
          </p>
        </div>

        <div class="gradient-border mb-4">
          <h4><i class="fas fa-map-marker-alt me-2"></i>Mailing Address</h4>
          <p>
            Nainital Almora Road,<br />
            Uttarakhand 263132, India
          </p>
        </div>
      </div>

      <!-- Support Options -->
      <div class="col-md-6">
        <div class="gradient-border mb-4 text-center">
          <i class="fas fa-comments fa-2x mb-2"></i>
          <h5>Live Support</h5>
          <p>Live Chat & Support Solution</p>
        </div>

        <div class="gradient-border mb-4 text-center">
          <i class="fas fa-ticket-alt fa-2x mb-2"></i>
          <h5>Send Ticket</h5>
          <p>Register your support ticket with us.</p>
        </div>

        <div class="gradient-border mb-4 text-center">
          <i class="fas fa-book fa-2x mb-2"></i>
          <h5>Knowledge Base</h5>
          <p>Check FAQs & guides for instant answers.</p>
        </div>
      </div>
    </div>

    <!-- Google Map Embed -->
    <div class="row mt-5">
      <div class="col">
        <div class="gradient-border p-2">
          <iframe 
            src="https://www.google.com/maps?q=Nainital+Almora+Road,+Uttarakhand+263132&output=embed" 
            width="100%" height="350" style="border:0;" allowfullscreen="" loading="lazy">
          </iframe>
        </div>
      </div>
    </div>

  </div>
</section>

<!-- Styles -->
<style>
  .gradient-border {
    border: 3px solid transparent;
    border-radius: 12px;
    background: linear-gradient(#0d1117, #0d1117) padding-box,
                linear-gradient(135deg, #6a11cb, #a044ff) border-box;
    padding: 20px 15px;
    transition: all 0.3s ease;
  }
  .gradient-border:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 20px rgba(160, 68, 255, 0.6);
  }
  .section-title {
    font-size: 2rem;
    font-weight: 600;
  }
  .gradient-text {
    background: linear-gradient(135deg, #6a11cb, #a044ff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
  }
</style>
</asp:Content>
