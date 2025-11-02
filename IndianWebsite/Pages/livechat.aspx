<%@ Page Title="Live Chat" Async="true" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="livechat.aspx.cs" Inherits="Pages_livechat" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container d-flex justify-content-center align-items-center" style="height: 90vh; background: #121212;">
    <div class="chat-card shadow-lg rounded-4 p-4 bg-dark text-light" style="width: 100%; max-width: 600px;">
        <h4 class="text-center mb-3" style="color:#0dcaf0;">💬 Chat with Support</h4>

        <!-- Email Section -->
        <div id="emailSection" runat="server" class="text-center">
            <h6 class="text-muted mb-3">Enter your email to start chatting</h6>
            <asp:TextBox ID="txtUserEmail" runat="server" CssClass="form-control mb-3" 
                         Placeholder="Enter your email"></asp:TextBox>
            <asp:Button ID="btnStartChat" runat="server" CssClass="btn btn-primary w-50"
                        Text="Start Chat" OnClick="btnStartChat_Click" OnClientClick="showLoader();" />
            <div id="loader" style="display:none;" class="mt-2 text-center">
                <div class="lds-dual-ring"></div>
            </div>
            <asp:Label ID="lblEmailError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
        <!-- OTP Section -->
<div id="otpSection" runat="server" visible="false" class="text-center">
    <h6 class="text-muted mb-3">Enter the OTP sent to your email</h6>
    <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control mb-3" 
                 Placeholder="Enter 6-digit OTP"></asp:TextBox>
    <asp:Button ID="btnVerifyOTP" runat="server" CssClass="btn btn-success w-50"
                Text="Verify OTP" OnClick="btnVerifyOTP_Click" />
    <asp:Label ID="lblOTPError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
</div>

        <!-- Chat Section -->
        <div id="chatSection" runat="server" visible="false" class="mt-3 d-flex flex-column">
            <div class="text-muted mb-2">Chatting as: <asp:Label ID="lblUserEmail" runat="server"></asp:Label></div>
            <div id="chatBox" class="flex-grow-1 p-3 rounded-3 mb-2" 
                 style="height:300px; overflow-y:auto; background-color:#1e1e1e;"></div>

            <div class="input-group">
                <input type="text" id="txtMessage" class="form-control rounded-start" 
                       placeholder="Type your message..." style="background:#2c2c2c; color:#fff; border:none;" />
                <button id="btnSend" class="btn btn-success rounded-end">Send</button>
            </div>
        </div>
    </div>
</div>

<!-- Loader CSS -->
<style>
.lds-dual-ring {
  display: inline-block; width: 40px; height: 40px;
}
.lds-dual-ring:after {
  content: " "; display: block; width: 32px; height: 32px; margin: 4px;
  border-radius: 50%; border: 3px solid #0d6efd;
  border-color: #0d6efd transparent #0d6efd transparent;
  animation: lds-dual-ring 1.2s linear infinite;
}
@keyframes lds-dual-ring { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
</style>

<!-- Scripts -->
<script src="<%= ResolveUrl("~/Scripts/jquery-3.6.0.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/jquery.signalR-2.4.3.min.js") %>"></script>
<script src="<%= ResolveUrl("~/signalr/hubs") %>"></script>

<script>
function showLoader() { 
    document.getElementById("loader").style.display = "inline-block"; 
}

(function waitForHub() {
    if (typeof $.connection === 'undefined' || typeof $.connection.chatHub === 'undefined') {
        setTimeout(waitForHub, 100); 
        return;
    }

    var chat = $.connection.chatHub;
    var email = '<%= lblUserEmail.Text %>';

    // ✅ Function to render messages in chat box
    function renderMessages(messages) {
        if (!messages || messages.length === 0) {
            $('#chatBox').html('<div class="text-center text-muted small">No previous messages</div>');
            return;
        }

        $('#chatBox').empty();
        messages.forEach(function(m) {
            let cls = m.Sender === "System" ? "text-muted text-center small"
                : m.Sender === email ? "text-end my-1"
                : "text-start my-1";

            let color = m.Sender === email ? "bg-success text-light"
                : m.Sender === "System" ? ""
                : "bg-secondary text-light";

            let html = m.Sender === "System"
                ? `<div class="${cls}">${m.Message}</div>`
                : `<div class="${cls}"><span class="badge rounded-pill ${color}">${m.Sender === email ? m.Message : m.Sender + ': ' + m.Message}</span></div>`;
            
            $('#chatBox').append(html);
        });
        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    }

    // ✅ Receive messages live
    chat.client.broadcastMessage = function(sender, message) {
        let cls = sender === "System" ? "text-muted text-center small" :
                  sender === email ? "text-end my-1" : "text-start my-1";
        let color = sender === email ? "bg-success text-light" :
                    sender === "System" ? "" : "bg-secondary text-light";
        let html = sender === "System"
            ? `<div class="${cls}">${message}</div>`
            : `<div class="${cls}"><span class="badge rounded-pill ${color}">${sender === email ? message : sender + ': ' + message}</span></div>`;
        
        $('#chatBox').append(html);
        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    };

    // ✅ Start hub connection
    $.connection.hub.start().done(function() {
        chat.server.joinRoom(email);

        // ✅ Show old messages immediately
        if (typeof previousMessages !== "undefined" && previousMessages.length > 0) {
            renderMessages(previousMessages);
        }

        // ✅ Send message
        $('#btnSend').off('click').on('click', function(e) {
            e.preventDefault();
            var msg = $('#txtMessage').val().trim();
            if (msg === '') return;
            chat.server.sendToRoom(email, msg, email);
            $('#txtMessage').val('');
        });

        // ✅ Send on Enter
        $('#txtMessage').off('keypress').on('keypress', function(e) {
            if (e.which === 13) $('#btnSend').click();
        });
    });
})();
</script>


</asp:Content>
