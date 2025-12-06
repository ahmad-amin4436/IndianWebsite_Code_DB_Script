using Microsoft.AspNet.SignalR;
using Renci.SshNet;
using System.Collections.Concurrent;
using System.Threading.Tasks;

public class SshHub : Hub
{
    private static ConcurrentDictionary<string, ShellStream> userShells =
        new ConcurrentDictionary<string, ShellStream>();

    private static ConcurrentDictionary<string, SshClient> userClients =
        new ConcurrentDictionary<string, SshClient>();

    public void ConnectSSH(string host, string user, string pass)
    {
        string connectionId = Context.ConnectionId;

        var client = new SshClient(host, user, pass);
        client.Connect();

        var shell = client.CreateShellStream("xterm", 80, 24, 800, 600, 1024);
        shell.WriteLine("stty -echo"); // disable remote echo

        userShells[connectionId] = shell;
        userClients[connectionId] = client;

        // Read SSH output continuously
        Task.Run(() =>
        {
            while (client.IsConnected)
            {
                string output = shell.Read();
                if (!string.IsNullOrEmpty(output))
                    Clients.Client(connectionId).ReceiveOutput(output);
            }
        });
    }

    public void SendInput(string input)
    {
        string id = Context.ConnectionId;

        if (userShells.TryGetValue(id, out ShellStream shell))
        {
            shell.Write(input);
        }
    }

    public override System.Threading.Tasks.Task OnDisconnected(bool stopCalled)
    {
        string id = Context.ConnectionId;

        if (userClients.TryRemove(id, out SshClient client))
            client.Dispose();

        if (userShells.TryRemove(id, out ShellStream shell))
            shell.Dispose();

        return base.OnDisconnected(stopCalled);
    }
}
