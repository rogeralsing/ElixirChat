defmodule Chat.Server do
  import Chat.Util

  def run do
    spawn fn -> loop %{clients: MapSet.new} end

  end

  defp loop state do
    clients = state.clients
    receive do
      {:connect,userName,client} ->
        send_all clients,{:connect,userName}
        send client,{:welcome,userName}
        loop %{state | clients: MapSet.put(clients, client)}
      {:say,userName,message} ->
        send_all clients,{:say,userName,message}
        loop state
      {:nick,oldUserName,newUserName} ->
        send_all clients,{:nick,oldUserName,newUserName}
        loop state
    end
  end
end
