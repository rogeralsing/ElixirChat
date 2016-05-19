defmodule Chat.ClientReader do

  def run server,client_writer do
    nick = "Roger"
    send server, {:connect,nick,client_writer}
    loop server, nick
  end

  defp loop server, nick do
    case IO.gets(">") |> String.strip do
      "/nick " <> new_username ->
        send server, {:nick,nick,new_username}
        loop server, new_username
      "/quit" -> []
      "/" <> command ->
        IO.puts "Unknown command #{command}"
        loop server, nick
      "" -> loop server, nick
      text ->
        send server, {:say,nick,text}
        loop server, nick
    end
  end
end
