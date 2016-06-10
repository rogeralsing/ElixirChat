defmodule Chat.ClientReader do

  def run client_writer do
    nick = "Roger"
    Server.connect(nick, client_writer)
    loop nick
  end

  defp loop nick do
    case IO.gets(">") |> String.strip do
      "/nick " <> new_username ->
        Server.nick(nick,new_username)
        loop new_username
      "/quit" -> []
      "/" <> command ->
        IO.puts "Unknown command #{command}"
        loop nick
      "" -> loop nick
      text ->
        Server.say(nick,text)
        loop nick
    end
  end
end
