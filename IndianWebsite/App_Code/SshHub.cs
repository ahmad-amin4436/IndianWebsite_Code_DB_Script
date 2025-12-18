using Microsoft.AspNet.SignalR;
using Renci.SshNet;
using Renci.SshNet.Common;
using System;
using System.Collections.Concurrent;
using System.Text;
using System.Threading.Tasks;

public class SshHub : Hub
{
    // Keep track of user SSH sessions
    private static ConcurrentDictionary<string, ShellStream> userShells =
        new ConcurrentDictionary<string, ShellStream>();

    private static ConcurrentDictionary<string, SshClient> userClients =
        new ConcurrentDictionary<string, SshClient>();

    public void ConnectSSH(string host, string user, string pass)
    {
        string connectionId = Context.ConnectionId;

        // Prevent multiple connections
        if (userClients.ContainsKey(connectionId))
        {
            Clients.Client(connectionId).ReceiveError("Already connected. Disconnect first.");
            return;
        }

        try
        {
            var client = new SshClient(host, user, pass);
            client.Connect();

            if (!client.IsConnected)
            {
                Clients.Client(connectionId).ReceiveError("SSH connection failed.");
                return;
            }

            // Create shell stream
            var shell = client.CreateShellStream("xterm", 80, 24, 800, 600, 1024);
            shell.WriteLine("stty -echo"); // disable remote echo

            userClients[connectionId] = client;
            userShells[connectionId] = shell;

            Clients.Client(connectionId).ConnectionStatus("connected", $"Connected to {user}@{host}");

            // Read output asynchronously
            Task.Run(async () =>
            {
                var buffer = new byte[1024];

                while (client.IsConnected && shell.CanRead)
                {
                    try
                    {
                        int read = await shell.ReadAsync(buffer, 0, buffer.Length);

                        if (read > 0)
                        {
                            string output = Encoding.UTF8.GetString(buffer, 0, read);
                            Clients.Client(connectionId).ReceiveOutput(output);
                        }
                        else
                        {
                            // Prevent tight loop if no data
                            await Task.Delay(10);
                        }
                    }
                    catch (Exception ex)
                    {
                        Clients.Client(connectionId).ReceiveError($"Read error: {ex.Message}");
                        break;
                    }
                }

                // Clean up after disconnect
                DisconnectSSH();
            });
        }
        catch (Exception ex)
        {
            Clients.Client(connectionId).ReceiveError($"SSH connection failed: {ex.Message}");
            DisconnectSSH();
        }
    }

    public void SendInput(string input)
    {
        string connectionId = Context.ConnectionId;

        if (userShells.TryGetValue(connectionId, out ShellStream shell) && shell.CanWrite)
        {
            try
            {
                shell.Write(input);
            }
            catch (Exception ex)
            {
                Clients.Client(connectionId).ReceiveError($"Send input failed: {ex.Message}");
            }
        }
    }

    public void DisconnectSSH()
    {
        string connectionId = Context.ConnectionId;

        if (userClients.TryRemove(connectionId, out SshClient client))
        {
            try
            {
                if (client.IsConnected)
                    client.Disconnect();
            }
            catch { }
            finally
            {
                client.Dispose();
            }
        }

        if (userShells.TryRemove(connectionId, out ShellStream shell))
        {
            try { shell.Dispose(); } catch { }
        }

        Clients.Client(connectionId).ConnectionStatus("disconnected", "Disconnected");
    }

    public override Task OnDisconnected(bool stopCalled)
    {
        // Ensure cleanup on disconnect
        DisconnectSSH();
        return base.OnDisconnected(stopCalled);
    }
}
