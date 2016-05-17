defmodule ClientReader do

  def run server,clientWriter do
    nick = "Roger"
    send server, {:connect,nick,clientWriter}
    loop %{server: server,nick: nick}
  end

  defp loop state do
    case IO.gets(">") |> String.strip do
      "/nick " <> newNick ->
        send state.server, {:nick,state.nick,newNick}
        loop %{state | nick: newNick}
      "/quit" -> {}
      "/" <> command ->
        IO.puts "Unknown command #{command}"
        loop state
      "" -> loop state
      text ->
        send state.server, {:say,state.nick,text}
        loop state
    end
  end
end
