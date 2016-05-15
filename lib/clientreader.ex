defmodule ClientReader do
  def run(server,clientWriter) do
    nick = "Roger"
    send server, {:connect,nick,clientWriter}
    loop {server,nick}
  end

  defp loop(state) do
    {server,nick} = state
    case IO.gets(">") |> String.strip do
      "/nick " <> newNick ->
        send server, {:nick,nick,newNick}
        loop {server,newNick}
      "/quit" -> {}
      "/" <> command ->
        IO.puts "Unknown command #{command}"
        loop state
      "" -> loop state
      text ->
        send server, {:say,nick,text}
        loop state
    end
  end
end
