defmodule ChatServer do
  use GenServer
  use Database
  use Amnesia
  require Amnesia

  def start(_type, _args) do
    run()
  end

  def run() do
    Amnesia.Schema.create
    Amnesia.start
    Database.create(disk: [node])
    Database.wait
    GenServer.start_link(__MODULE__, MapSet.new, name: {:global, :server})
  end

  def handle_cast({:connect,username,client}, clients) do
    log username, "#{username} connected"
    send_all clients,{:connect,username}
    send client,{:welcome,username}

     data = Amnesia.transaction do
        ChatLog.where(true, select: message).values
     end
     send client,{:history, data}

    {:noreply,  MapSet.put(clients, client)}
  end

  def handle_cast({:say,username,message}, clients) do
    log username, "#{username} says #{message}"
    send_all clients,{:say,username,message}
    {:noreply, clients}
  end

  def handle_cast({:nick,old_username,new_username}, clients) do
    log old_username, "#{old_username} changed nick to #{new_username}"
    send_all clients,{:nick,old_username,new_username}
    {:noreply, clients}
  end

  def handle_cast(any, clients) do
    log "???", "Unknown #{any}"
    {:noreply, clients}
  end

  defp send_all clients,message do
    for client <- clients, do: send client, message
  end

  defp log(user,message) do
    IO.puts message
    Amnesia.transaction do
      %ChatLog{timestamp: 0, user: user, message: message} |> ChatLog.write
    end
  end
end
