defmodule ChatServer do
  use GenServer

  def start(_type, _args) do
    Database.setup()
    GenServer.start_link(__MODULE__, MapSet.new, name: {:global, :server})
  end

  def handle_cast({:connect,username,client}, clients) do
    IO.puts "#{username} connected"
    send_all clients,{:connect,username}
    send client,{:welcome,username}

     for message <- Database.history do
       send client, message
     end

    {:noreply,  MapSet.put(clients, client)}
  end

  def handle_cast({:say,username,message}, clients) do
    IO.puts "#{username} says #{message}"
    send_all clients,{:say,username,message}
    {:noreply, clients}
  end

  def handle_cast({:nick,old_username,new_username}, clients) do
    IO.puts "#{old_username} changed nick to #{new_username}"
    send_all clients,{:nick,old_username,new_username}
    {:noreply, clients}
  end

  def handle_cast(any, clients) do
    IO.puts "Unknown #{any}"
    {:noreply, clients}
  end

  defp send_all clients,message do
    Database.append message
    for client <- clients do
      send client, message
    end
  end
end
