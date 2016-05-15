defmodule Server do
  def run() do
    spawn(fn -> act({MapSet.new()}) end)
  end

  defp notify(clients,message) do
    for client <- clients  do
      send client, message
    end
  end

  defp act(state) do
    {clients} = state
    receive do
      {:connect,userName,clientPID} ->
        notify(clients,{:connect,userName})
        send clientPID,{:welcome,userName}
        act({MapSet.put(clients, clientPID)})
      {:say,userName,message} ->
        notify(clients,{:say,userName,message})
        act(state)
      {:nick,oldUserName,newUserName} ->
        notify(clients,{:nick,oldUserName,newUserName})
        act(state)
    end
  end
end
