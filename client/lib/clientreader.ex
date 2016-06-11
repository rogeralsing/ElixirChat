defmodule Chat.ClientReader do

  def run username, client_writer do
    Server.connect(username, client_writer)
    repl username
  end

  defp repl username do
    IO.gets(">")
    |> String.strip
    |> handle(username)
    |> repl
  end

  defp handle("/nick " <> new_username, username) do
    Server.nick(username,new_username)
    new_username
  end

  defp handle("/quit", username) do
    Kernel.exit("end")
  end

  defp handle("/" <> command, username) do
    IO.puts "Unknown command #{command}"
    username
  end

  defp handle("", username) do
    username
  end

  defp handle(text, username) do
    Server.say(username,text)
    username
  end

end
