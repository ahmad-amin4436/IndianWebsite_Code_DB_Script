using Microsoft.AspNet.SignalR;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading.Tasks;

public class ChatHub : Hub
{
    private static ConcurrentDictionary<string, string> UserRooms = new ConcurrentDictionary<string, string>();
    public static ConcurrentDictionary<string, string> ActiveCustomers = new ConcurrentDictionary<string, string>();
    DAL _dal = new DAL();

    public override async Task OnDisconnected(bool stopCalled)
    {
        if (UserRooms.TryRemove(Context.ConnectionId, out string roomName))
        {
            await Groups.Remove(Context.ConnectionId, roomName);

            string emailToRemove = null;
            foreach (var pair in ActiveCustomers)
            {
                if (pair.Value == Context.ConnectionId)
                {
                    emailToRemove = pair.Key;
                    break;
                }
            }

            if (emailToRemove != null)
            {
                ActiveCustomers.TryRemove(emailToRemove, out _);
                Clients.All.updateActiveUsers(ActiveCustomers.Keys);
            }
        }
        await base.OnDisconnected(stopCalled);
    }

    public async Task JoinRoom(string email)
    {
        string room = email.ToLower();
        ActiveCustomers[email] = Context.ConnectionId;
        UserRooms[Context.ConnectionId] = room;

        await Groups.Add(Context.ConnectionId, room);
        Clients.Group(room).broadcastMessage("System", $"{email} joined the chat. Please wait for agaent.");
        Clients.All.updateActiveUsers(ActiveCustomers.Keys);

        // ✅ Send existing chat history from database
        var messages = _dal.GetMessages(room);
        Clients.Caller.showChatHistory(messages);
    }

    public async Task JoinAgent(string customerEmail)
    {
        string room = customerEmail.ToLower();
        await Groups.Add(Context.ConnectionId, room);

        Clients.Group(room).broadcastMessage("System", $"Agent joined chat with {customerEmail}.");

        // ✅ Get chat history from database (store procedure)
        var messages = _dal.GetMessages(room); // returns List<ChatMessage> { Sender, Message, Timestamp }

        // ✅ Send to agent
        Clients.Caller.showChatHistory(messages);
    }

    public void SendToRoom(string roomEmail, string message, string sender)
    {
        string room = roomEmail.ToLower();
        Clients.Group(room).broadcastMessage(sender, message);

        try
        {
            _dal.SaveMessage(roomEmail, sender, message);
        }
        catch (System.Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Error saving chat: " + ex.Message);
        }
    }

    public void GetActiveUsers()
    {
        Clients.Caller.updateActiveUsers(ActiveCustomers.Keys);
    }
}
