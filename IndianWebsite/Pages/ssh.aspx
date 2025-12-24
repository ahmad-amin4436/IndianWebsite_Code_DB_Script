    <%@ Page Title="SSH Terminal" Async="true" Language="C#" MasterPageFile="~/Site.master"
        AutoEventWireup="true" CodeFile="ssh.aspx.cs" Inherits="Pages_ssh" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* DarkStar Theme Enhancements */
        .ssh-wrapper {
            background: linear-gradient(135deg, #0c0c0c 0%, #1a1a1a 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', 'Roboto', sans-serif;
        }
        .xterm-scroll-area{
            height: auto !important;
        }
        .xterm-helpers{
            display:;
        }
        .ssh-card {
            width: 100%;
            max-width: 850px;
            background: rgba(25, 25, 25, 0.95);
            color: #e0e0e0;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5),
                        0 0 0 1px rgba(13, 202, 240, 0.1);
            backdrop-filter: blur(10px);
            display: flex;
            flex-direction: column;
            gap: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .ssh-card:hover {
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.6),
                        0 0 0 1px rgba(13, 202, 240, 0.2);
        }

        /* Input Groups */
        .input-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .input-label {
            font-size: 14px;
            color: #0dcaf0;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-label i {
            font-size: 16px;
        }

        .ssh-input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid rgba(51, 51, 51, 0.8);
            background: rgba(15, 15, 15, 0.9);
            color: #f0f0f0;
            outline: none;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .ssh-input:focus {
            border-color: #0dcaf0;
            background: rgba(20, 20, 20, 0.95);
            box-shadow: 0 0 0 3px rgba(13, 202, 240, 0.2),
                        inset 0 2px 4px rgba(0, 0, 0, 0.4);
        }

        .ssh-input::placeholder {
            color: #666;
        }

        /* Button Enhancements */
        .ssh-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #0dcaf0 0%, #0bb7d9 100%);
            border: none;
            border-radius: 10px;
            color: #000;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(13, 202, 240, 0.3);
            position: relative;
            overflow: hidden;
        }

        .ssh-btn:hover {
            background: linear-gradient(135deg, #0bb7d9 0%, #0aa5c2 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(13, 202, 240, 0.4);
        }

        .ssh-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 10px rgba(13, 202, 240, 0.3);
        }

        .ssh-btn.connecting {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        }

        .ssh-btn.connected {
            background: linear-gradient(135deg, #198754 0%, #157347 100%);
        }

        /* Connection Status */
        .connection-status {
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            text-align: center;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        .status-disconnected {
            background: rgba(220, 53, 69, 0.15);
            color: #f8d7da;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .status-connecting {
            background: rgba(255, 193, 7, 0.15);
            color: #fff3cd;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-connected {
            background: rgba(25, 135, 84, 0.15);
            color: #d1e7dd;
            border: 1px solid rgba(25, 135, 84, 0.3);
        }

        /* Terminal Container */
        .terminal-container {
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: inset 0 2px 10px rgba(0, 0, 0, 0.5);
            position: relative;
        }

        .terminal-header {
            background: rgba(30, 30, 30, 0.95);
            padding: 12px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .terminal-title {
            color: #0dcaf0;
            font-weight: 600;
            font-size: 14px;
        }

        .terminal-actions {
            display: flex;
            gap: 8px;
        }

        .term-btn {
            padding: 6px 12px;
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 6px;
            color: #ccc;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .term-btn:hover {
            background: rgba(13, 202, 240, 0.2);
            color: #0dcaf0;
        }
        .terminal-container {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        #terminal {
            flex: 1;
            width: 100%;
            background: #000;
            overflow-y: auto;
        }


        /* Responsive Design */
        @media (max-width: 1024px) {
            .ssh-card {
                padding: 25px;
                max-width: 90%;
            }
        
            #terminal {
                height: calc(100vh - 400px);
                max-height: 500px;
            }
        }

        @media (max-width: 768px) {
            .ssh-wrapper {
                padding: 15px;
            }
        
            .ssh-card {
                padding: 20px;
                max-width: 95%;
                border-radius: 16px;
            }
        
            #terminal {
                height: calc(100vh - 380px);
                max-height: 450px;
            }
        
            .terminal-header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }
        
            .terminal-actions {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .ssh-wrapper {
                padding: 10px;
            }
        
            .ssh-card {
                padding: 16px;
                border-radius: 12px;
            }
        
            #terminal {
                height: calc(100vh - 350px);
                min-height: 250px;
                max-height: 400px;
            }
        
            .ssh-input {
                padding: 12px 14px;
                font-size: 14px;
            }
        
            .ssh-btn {
                padding: 13px;
                font-size: 15px;
            }
        }

        @media (max-height: 600px) {
            #terminal {
                height: 300px;
                min-height: 250px;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        /* Loading Animation */
        .loader {
            display: inline-block;
            width: 12px;
            height: 12px;
            border: 2px solid rgba(13, 202, 240, 0.3);
            border-radius: 50%;
            border-top-color: #0dcaf0;
            animation: spin 1s linear infinite;
            margin-left: 8px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Error Message */
        .error-message {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #f8d7da;
            padding: 12px;
            border-radius: 8px;
            margin-top: 10px;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        /* Quick Actions */
        .quick-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .quick-btn {
            padding: 8px 16px;
            background: rgba(13, 202, 240, 0.1);
            border: 1px solid rgba(13, 202, 240, 0.3);
            border-radius: 6px;
            color: #0dcaf0;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
            flex: 1;
            min-width: 100px;
            text-align: center;
        }

        .quick-btn:hover {
            background: rgba(13, 202, 240, 0.2);
            transform: translateY(-1px);
        }
    </style>

    <div class="ssh-wrapper">
        <div class="ssh-card">

            <div style="text-align:center; margin-bottom: 10px;">
                <h3 style="color:#0dcaf0; margin:0; font-size:28px; font-weight:600;">SSH Terminal</h3>
                <p style="color:#888; margin:5px 0 20px 0; font-size:14px;">Secure Shell Access</p>
            </div>

            <!-- Connection Status -->
            <div id="statusMessage" class="connection-status status-disconnected">
                <i class="fas fa-plug" style="margin-right:8px;"></i>
                <span>Disconnected</span>
            </div>

            <!-- Error Message -->
            <div id="errorMessage" class="error-message"></div>

            <!-- Input Groups -->
            <div class="input-group">
                <label class="input-label">
                    <i class="fas fa-server"></i> Server Host
                </label>
                <asp:TextBox ID="txtHost" runat="server"
                    CssClass="ssh-input"
                    Placeholder="e.g., 192.168.1.10 or example.com"
                    autocomplete="off">
                </asp:TextBox>
            </div>

            <div class="input-group">
                <label class="input-label">
                    <i class="fas fa-user"></i> Username
                </label>
                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="ssh-input"
                    Placeholder="Enter SSH username"
                    autocomplete="off">
                </asp:TextBox>
            </div>

            <div class="input-group">
                <label class="input-label">
                    <i class="fas fa-key"></i> Password
                </label>
                <asp:TextBox ID="txtPassword" runat="server" 
                    CssClass="ssh-input" TextMode="Password"
                    Placeholder="Enter SSH password"
                    autocomplete="off">
                </asp:TextBox>
            </div>

          

            <!-- Connect button -->
            <asp:Button ID="btnStart" runat="server" Text="Connect SSH"
                CssClass="ssh-btn" OnClientClick="connectSSH(); return false;" />

            <!-- Terminal Container -->
            <div class="terminal-container">
                <div class="terminal-header">
                    <div class="terminal-title">
                        <i class="fas fa-terminal"></i> Terminal Session
                        <span id="sessionInfo" style="color:#888; margin-left:10px; font-size:12px;"></span>
                    </div>
                    <%--<div class="terminal-actions">
                        <button class="term-btn" onclick="clearTerminal()">
                            <i class="fas fa-broom"></i> Clear
                        </button>
                        <button class="term-btn" onclick="copyTerminalContent()">
                            <i class="fas fa-copy"></i> Copy
                        </button>
                        <button class="term-btn" onclick="toggleFullscreen()">
                            <i class="fas fa-expand"></i> Fullscreen
                        </button>
                    </div>--%>
                </div>
                <div id="terminal"></div>
            </div>

            <!-- Session Stats -->
            <div style="display:flex; justify-content:space-between; color:#888; font-size:12px; margin-top:10px;">
                <div>
                    <i class="fas fa-clock"></i> 
                    <span id="sessionTimer">00:00:00</span>
                </div>
                <div>
                    <i class="fas fa-keyboard"></i> 
                    <span id="keyCount">0 keys</span>
                </div>
                <div>
                    <i class="fas fa-wifi"></i> 
                    <span id="connectionStatus">Disconnected</span>
                </div>
            </div>

        </div>
    </div>

    <!-- Libraries -->
    <script src="/Scripts/jquery-3.6.0.min.js"></script>
    <script src="/Scripts/jquery.signalR-2.4.3.min.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="https://cdn.jsdelivr.net/npm/xterm@5.3.0/lib/xterm.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/xterm-addon-fit@0.7.0/lib/xterm-addon-fit.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <script>
        // Global variables
        var hub = $.connection.sshHub;
        var term = null;
        var fitAddon = null;
        var sessionStartTime = null;
        var timerInterval = null;
        var keyCount = 0;
        var isConnected = false;
        var isFullscreen = false;

        // Initialize terminal
        function initTerminal() {
            if (term) {
                term.dispose();
            }
        
            term = new Terminal({
                cursorBlink: true,
                fontSize: 14,
                fontFamily: "'Cascadia Code', 'Consolas', monospace",
                theme: {
                    background: '#000',
                    foreground: '#0dcaf0',
                    cursor: '#0dcaf0',
                    selection: 'rgba(13, 202, 240, 0.3)',
                    black: '#000000',
                    red: '#ff5555',
                    green: '#50fa7b',
                    yellow: '#f1fa8c',
                    blue: '#bd93f9',
                    magenta: '#ff79c6',
                    cyan: '#8be9fd',
                    white: '#bfbfbf',
                    brightBlack: '#4d4d4d',
                    brightRed: '#ff6e6e',
                    brightGreen: '#69ff94',
                    brightYellow: '#ffffa5',
                    brightBlue: '#d6acff',
                    brightMagenta: '#ff92df',
                    brightCyan: '#a4ffff',
                    brightWhite: '#ffffff'
                },
                scrollback: 5000,
                convertEol: true,
                allowProposedApi: true,
                cursorStyle: 'block',
                allowTransparency: true,
                cols: 120,
                rows: 30
            });

            fitAddon = new FitAddon.FitAddon();
            term.loadAddon(fitAddon);
            term.open(document.getElementById('terminal'));
            fitAddon.fit();
        
            term.write('\x1b[1;32m>>>\x1b[0m SSH Terminal Ready. Enter credentials and press Connect.\r\n');
            term.write('\x1b[1;36m>>>\x1b[0m Use Ctrl+C to interrupt, Ctrl+D to disconnect\r\n\r\n');
        }

        // Update connection status
        function updateStatus(status, message) {
            const statusEl = $('#statusMessage');
            const btn = $('.ssh-btn');
            const connStatus = $('#connectionStatus');
        
            statusEl.show().removeClass('status-disconnected status-connecting status-connected');
            btn.removeClass('connecting connected');
        
            switch(status) {
                case 'connecting':
                    statusEl.addClass('status-connecting').html('<i class="fas fa-spinner fa-spin"></i> ' + message);
                    btn.addClass('connecting').html('<span class="loader"></span> Connecting...');
                    connStatus.text('Connecting').css('color', '#ffc107');
                    break;
                case 'connected':
                    statusEl.addClass('status-connected').html('<i class="fas fa-check-circle"></i> ' + message);
                    btn.addClass('connected').html('<i class="fas fa-plug"></i> Connected');
                    connStatus.text('Connected').css('color', '#198754');
                    isConnected = true;
                    startSessionTimer();
                    break;
                case 'disconnected':
                    statusEl.addClass('status-disconnected').html('<i class="fas fa-times-circle"></i> ' + message);
                    btn.html('<i class="fas fa-plug"></i> Connect SSH');
                    connStatus.text('Disconnected').css('color', '#dc3545');
                    isConnected = false;
                    stopSessionTimer();
                    break;
                case 'error':
                    $('#errorMessage').text(message).show();
                    setTimeout(() => $('#errorMessage').fadeOut(), 5000);
                    break;
            }
        }

        // Session timer
        function startSessionTimer() {
            sessionStartTime = new Date();
            stopSessionTimer();
            timerInterval = setInterval(updateTimer, 1000);
        }

        function stopSessionTimer() {
            if (timerInterval) {
                clearInterval(timerInterval);
                timerInterval = null;
            }
        }

        function updateTimer() {
            if (!sessionStartTime) return;
        
            const now = new Date();
            const diff = Math.floor((now - sessionStartTime) / 1000);
            const hours = Math.floor(diff / 3600);
            const minutes = Math.floor((diff % 3600) / 60);
            const seconds = diff % 60;
        
            $('#sessionTimer').text(
                `${hours.toString().padStart(2, '0')}:` +
                `${minutes.toString().padStart(2, '0')}:` +
                `${seconds.toString().padStart(2, '0')}`
            );
        }

        // Quick fill functions
        function quickFill(host, user, pass) {
            $("#<%=txtHost.ClientID%>").val(host);
            $("#<%=txtUsername.ClientID%>").val(user);
            $("#<%=txtPassword.ClientID%>").val(pass);
        
            term.write(`\x1b[1;33m>>>\x1b[0m Quick fill: ${host} | ${user}\r\n`);
        }

        function clearCredentials() {
            $("#<%=txtHost.ClientID%>").val('');
            $("#<%=txtUsername.ClientID%>").val('');
            $("#<%=txtPassword.ClientID%>").val('');
            term.write('\x1b[1;33m>>>\x1b[0m Credentials cleared\r\n');
        }

        // Terminal actions
        function clearTerminal() {
            if (confirm('Clear terminal output?')) {
                term.clear();
                term.write('\x1b[1;32m>>>\x1b[0m Terminal cleared\r\n\r\n');
            }
        }

        function copyTerminalContent() {
            const text = term.getSelection() || term.buffer.active;
            const content = text.getLine ? text.getLine(0).translateToString(true) : text;
        
            navigator.clipboard.writeText(content).then(() => {
                term.write('\x1b[1;32m>>>\x1b[0m Copied to clipboard\r\n');
            });
        }

        function toggleFullscreen() {
            const container = document.querySelector('.terminal-container');
        
            if (!isFullscreen) {
                if (container.requestFullscreen) {
                    container.requestFullscreen();
                } else if (container.webkitRequestFullscreen) {
                    container.webkitRequestFullscreen();
                }
                isFullscreen = true;
            } else {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.webkitExitFullscreen) {
                    document.webkitExitFullscreen();
                }
                isFullscreen = false;
            }
        }

        // SignalR Hub Methods
        let outputBuffer = '';
        let flushTimeout;

       hub.client.ReceiveOutput = function(data) {
            outputBuffer += data;
            if (!flushTimeout) {
                flushTimeout = setTimeout(() => {
                    term.write(outputBuffer);
                    outputBuffer = '';
                    flushTimeout = null;

                    // Ensure terminal scrolls to bottom
                    term.scrollToBottom();
                }, 50); // flush every 50ms for smoother scrolling
            }
        };



        hub.client.ConnectionStatus = function (status, message) {
            updateStatus(status, message);
        };

        hub.client.ReceiveError = function (error) {
            updateStatus('error', error);
            if (term) {
                term.write(`\x1b[1;31m>>> ERROR: ${error}\x1b[0m\r\n`);
            }
        };

        // Connect to SignalR
        $.connection.hub.start().done(function () {
            console.log("SignalR: Connected to SSH hub");
            updateStatus('disconnected', 'Ready to connect');
        }).fail(function (error) {
            console.error("SignalR connection failed:", error);
            updateStatus('error', 'SignalR connection failed');
        });

        // Main connection function
        function connectSSH() {
            if (isConnected) {
                if (confirm('Disconnect from current session?')) {
                    hub.server.disconnectSSH();
                    updateStatus('disconnected', 'Disconnected');
                    return;
                }
                return;
            }

            const host = $("#<%=txtHost.ClientID%>").val().trim();
            const user = $("#<%=txtUsername.ClientID%>").val().trim();
            const pass = $("#<%=txtPassword.ClientID%>").val();

            if (!host || !user) {
                updateStatus('error', 'Host and Username are required');
                return;
            }

            updateStatus('connecting', `Connecting to ${host}...`);
            keyCount = 0;
        
            $('#sessionInfo').text(`${user}@${host}`);
        
            // Initialize terminal if not already
            if (!term) {
                initTerminal();
            }
        
            term.clear();
            term.write(`\x1b[1;36m>>>\x1b[0m Connecting to \x1b[1;33m${user}@${host}\x1b[0m...\r\n\r\n`);
        
            hub.server.connectSSH(host, user, pass);
        }

        // Terminal input handling
     function setupTerminalInput() {
    term.onData(function(data) {
        keyCount++;
        $('#keyCount').text(`${keyCount} keys`);

        // Handle Backspace locally
        if (data === '\x7F') { // Backspace
            term.write('\b \b'); // move back, overwrite with space, move back again
        } else {
            term.write(data);
        }
            term.scrollToBottom();

        // Send input to server if connected
        if (isConnected) {
            hub.server.sendInput(data);
        }
    });

         term.attachCustomKeyEventHandler(function (event) {
             if (event.ctrlKey && event.key === 'v') {
        event.preventDefault();

        if (!isConnected) return false;

        navigator.clipboard.readText()
            .then(function (text) {
                if (text) {
                    // Show pasted text in terminal
                    term.write(text);

                    // Send whole content at once to SSH
                    hub.server.sendInput(text);
                }
            })
            .catch(function (err) {
                console.error("Paste failed:", err);
            });

        return false;
    }
        if (event.ctrlKey && event.key === 'c') {
            if (isConnected) {
                hub.server.sendInput('\x03'); // Ctrl+C
                term.write('^C\r\n');
                return false;
            }
        }
        if (event.ctrlKey && event.key === 'd') {
            if (isConnected) {
                hub.server.disconnectSSH();
                term.write('\r\n\x1b[1;33m>>>\x1b[0m Disconnected\r\n');
                return false;
            }
        }
        return true;
    });
}


        // Window resize handler
           $(window).on('resize', function() {
                if (fitAddon) {
                    fitAddon.fit();  // adjust columns and rows
                    term.scrollToBottom();  // ensure viewport follows output
                }
            });


        // Initialize on page load
        $(document).ready(function() {
            initTerminal();
            setupTerminalInput();
        
            // Auto-focus first input
            $("#<%=txtHost.ClientID%>").focus();
        
            // Handle Enter key in inputs
            $('.ssh-input').on('keypress', function(e) {
                if (e.which === 13) { // Enter key
                    connectSSH();
                }
            });
        
            // Handle fullscreen change
            document.addEventListener('fullscreenchange', function() {
                isFullscreen = !!document.fullscreenElement;
                if (fitAddon) {
                    fitAddon.fit();
                }
            });
        });
    </script>

    </asp:Content>