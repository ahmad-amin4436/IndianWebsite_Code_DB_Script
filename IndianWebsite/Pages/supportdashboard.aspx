<%@ Page Title="Support Dashboard" Async="true" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="supportdashboard.aspx.cs" Inherits="Pages_supportdashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container-fluid d-flex justify-content-center align-items-center min-vh-100 bg-dark text-light">
    <div class="card shadow-lg rounded-4 p-4 w-100" style="max-width: 950px; background-color: #1a1a1a;">
        <h4 class="text-center mb-4 text-info">💬 Support Dashboard</h4>

        <div class="row g-3">
            <!-- Customer List -->
            <div class="col-12 col-md-4">
                <h6 class="text-muted mb-2">Active Customers</h6>
                <div id="customerList"
                     class="d-flex flex-column gap-2 border border-secondary rounded p-2"
                     style="max-height: 500px; overflow-y: auto;">
                    <div class="text-center text-muted small">No customers online</div>
                </div>
            </div>

            <!-- Chat Section -->
            <div class="col-12 col-md-8 d-flex flex-column">
                <!-- Chat Box -->
                <div id="chatBox"
                     class="flex-grow-1 mb-3 p-3 border border-secondary rounded"
                     style="background-color: #121212; overflow-y: auto; height: 400px;">
                    <div class="text-center text-muted small">Select a customer to start chatting</div>
                </div>

                <!-- Message Input -->
                <div class="input-group">
                    <input type="text" id="txtMessage"
                           class="form-control bg-dark text-light border-secondary"
                           placeholder="Type a message..." />
                    <button type="button" id="btnSend"
                            class="btn btn-info text-dark fw-semibold">
                        Send
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="<%= ResolveUrl("~/Scripts/jquery-3.6.0.min.js") %>"></script>
<script src="<%= ResolveUrl("~/Scripts/jquery.signalR-2.4.3.min.js") %>"></script>
<script src="<%= ResolveUrl("~/signalr/hubs") %>"></script>

<script>
(function waitForHub() {
    if (typeof $.connection === 'undefined' || typeof $.connection.chatHub === 'undefined') {
        setTimeout(waitForHub, 100);
        return;
    }

    var chat = $.connection.chatHub;
    var agentName = "Agent";
    var selectedEmail = null;

    // ✅ Receive broadcast messages
    chat.client.broadcastMessage = function(sender, message) {
        let cls = sender === "System"
            ? "text-center text-muted small"
            : sender === agentName
                ? "text-end my-1"
                : "text-start my-1";

        let color = sender === "System"
            ? ""
            : sender === agentName
                ? "bg-info text-dark"
                : "bg-secondary text-light";

        let html = sender === "System"
            ? `<div class="${cls}">${message}</div>`
            : `<div class="${cls}">
                   <span class="badge rounded-pill ${color}">
                       ${sender === agentName ? message : sender + ': ' + message}
                   </span>
               </div>`;

        $('#chatBox').append(html);
        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    };

    // ✅ Show chat history (now global, not inside click)
    chat.client.showChatHistory = function(messages) {
        $('#chatBox').empty();

        if (!messages || messages.length === 0) {
            $('#chatBox').append('<div class="text-center text-muted small">No previous messages</div>');
            return;
        }

        messages.forEach(function(msg) {
            let sender = msg.Sender;
            let message = msg.Message;
            let cls = sender === agentName ? "text-end my-1" : "text-start my-1";
            let color = sender === agentName ? "bg-info text-dark" : "bg-secondary text-light";

            let html = `<div class="${cls}">
                            <span class="badge rounded-pill ${color}">
                                ${sender === agentName ? message : sender + ': ' + message}
                            </span>
                        </div>`;
            $('#chatBox').append(html);
        });

        $('#chatBox').scrollTop($('#chatBox')[0].scrollHeight);
    };

    // ✅ Update active users list
    chat.client.updateActiveUsers = function(emails) {
        $('#customerList').empty();
        if (!emails || emails.length === 0) {
            $('#customerList').append('<div class="text-center text-muted small">No active customers</div>');
            return;
        }

        $.each(emails, function(i, email) {
            $('#customerList').append(`
                <button type="button" class="btn btn-outline-light btn-sm text-truncate user-item"
                        data-email="${email}" style="text-align:left;">
                    ${email}
                </button>`);
        });
    };

    // ✅ Start connection
    $.connection.hub.start().done(function() {
        if (chat.server.getActiveUsers) chat.server.getActiveUsers();

        // ✅ Select customer
        $(document).on('click', '.user-item', function(e) {
            e.preventDefault();
            selectedEmail = $(this).data('email');
            $('#chatBox').html(`<div class="text-center text-muted small my-2">Connected to ${selectedEmail}</div>`);

            // Ask server to join and get chat history
            chat.server.joinAgent(selectedEmail);
        });

        // ✅ Send message
        function sendMessage() {
            var msg = $('#txtMessage').val().trim();
            if (!msg || !selectedEmail) return;
            chat.server.sendToRoom(selectedEmail, msg, agentName);
            $('#txtMessage').val('');
        }

        $('#btnSend').on('click', function(e) {
            e.preventDefault();
            sendMessage();
        });

        $('#txtMessage').on('keypress', function(e) {
            if (e.which === 13) {
                e.preventDefault();
                sendMessage();
                return false;
            }
        });
    }).fail(function(err) {
        console.error("❌ Hub connection failed:", err);
    });
})();
</script>


</asp:Content>
