defmodule Chat.Server do
  import Chat.Util

  def run do
    spawn fn -> loop MapSet.new end
  end

  defp loop clients do
    receive do
      {:connect,username,client} ->
        send_all clients,{:connect,username}
        send client,{:welcome,username}
        loop MapSet.put(clients, client)
      {:say,username,message} ->
        send_all clients,{:say,username,message}
        loop clients
      {:nick,old_username,new_username} ->
        send_all clients,{:nick,old_username,new_username}
        loop clients
    end
  end
end
