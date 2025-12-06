<%@ Page Title="SSH Terminal" Async="true" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="ssh.aspx.cs" Inherits="Pages_ssh" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<style>
    /* TERMINAL CONTAINER */
#terminal {
    width: 100%;
    height: calc(100vh - 350px);
    max-height: 500px;
    min-height: 250px;
    background: #000;
    border-radius: 8px;
    overflow: auto !important;   /* ENABLE SCROLL */
}

/* xterm scroll fix */
.xterm-viewport {
    overflow-y: auto !important;
}
.xterm-screen {
    overflow: hidden !important;
}

/* Tablet */
@media (max-width: 768px) {
    #terminal {
        height: calc(100vh - 320px);
        max-height: 400px;
    }
}

/* Mobile */
@media (max-width: 480px) {
    #terminal {
        height: calc(100vh - 300px);
        max-height: 350px;
    }
}

/* FULL PAGE WRAPPER */
.ssh-wrapper {
    background: #121212;
    min-height: 100vh;
    padding: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* MAIN CARD */
.ssh-card {
    width: 100%;
    max-width: 750px;
    background: #1e1e1e;
    color: #eee;
    padding: 25px;
    border-radius: 16px;
    box-shadow: 0 0 15px rgba(0,0,0,0.4);
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* CUSTOM INPUTS */
.ssh-input {
    width: 100%;
    padding: 12px 14px;
    border: 1px solid #333;
    background: #111;
    color: #eee;
    outline: none;
    border-radius: 8px;
    font-size: 15px;
}
.ssh-input:focus {
    border-color: #0dcaf0;
}

/* CUSTOM BUTTON */
.ssh-btn {
    width: 100%;
    padding: 12px;
    background: #0dcaf0;
    border: none;
    border-radius: 8px;
    color: #000;
    font-size: 15px;
    cursor: pointer;
    transition: 0.2s;
}
.ssh-btn:hover {
    background: #0bb7d9;
}

/* TERMINAL */
#terminal {
    width: 100%;
    height: calc(100vh - 350px);
    max-height: 500px;
    min-height: 250px;
    background: #000;
    border-radius: 8px;
    overflow: hidden;
}

/* TABLET */
@media (max-width: 768px) {
    #terminal {
        height: calc(100vh - 320px);
        max-height: 400px;
    }
}

/* MOBILE */
@media (max-width: 480px) {
    .ssh-card {
        padding: 18px;
    }
    #terminal {
        height: calc(100vh - 300px);
        max-height: 350px;
    }
}

</style>

<div class="ssh-wrapper">
    <div class="ssh-card">

        <h3 style="text-align:center; color:#0dcaf0;">SSH Terminal Access</h3>

        <!-- Host -->
        <asp:TextBox ID="txtHost" runat="server"
            CssClass="ssh-input" Placeholder="Server Host (e.g. 192.168.1.10)">
        </asp:TextBox>

        <!-- Username -->
        <asp:TextBox ID="txtUsername" runat="server"
            CssClass="ssh-input" Placeholder="Username">
        </asp:TextBox>

        <!-- Password -->
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
            CssClass="ssh-input" Placeholder="Password">
        </asp:TextBox>

        <!-- Connect button -->
        <asp:Button ID="btnStart" runat="server" Text="Connect SSH"
            CssClass="ssh-btn" OnClientClick="connectSSH(); return false;" />

        <!-- Terminal -->
        <div id="terminal"></div>

    </div>
</div>

<!-- Libraries -->
<script src="/Scripts/jquery-3.6.0.min.js"></script>
<script src="/Scripts/jquery.signalR-2.4.3.min.js"></script>
<script src="/signalr/hubs"></script>
<script src="https://cdn.jsdelivr.net/npm/xterm@5.3.0/lib/xterm.js"></script>

<script>
    var hub = $.connection.sshHub;
    var term = new Terminal({
        cursorBlink: true,
        fontSize: 14
    });

    term.open(document.getElementById("terminal"));
    term.write(">>> Ready. Enter credentials and press Connect.\r\n");

    // Server to Terminal
    hub.client.ReceiveOutput = function (data) {
        term.write(data);
    };

    $.connection.hub.start().done(function () {
        console.log("SignalR: Connected");
    });

    // Terminal input to server
    term.onData(function (data) {
        term.write(data);              // 👈 instantly show typed characters
        hub.server.sendInput(data);    // send to server
    });


    function connectSSH() {
        let host = $("#<%=txtHost.ClientID%>").val();
        let user = $("#<%=txtUsername.ClientID%>").val();
        let pass = $("#<%=txtPassword.ClientID%>").val();

        term.write("\r\n>>> Connecting to " + host + "...\r\n");

        hub.server.connectSSH(host, user, pass);
    }
</script>

</asp:Content>
