defmodule Chat.ClientWriter do
  def run do
    spawn fn -> loop end
  end

  defp loop do
    receive do
      any -> handle(any)
    end
    loop
  end

  defp handle({:welcome,username}), do:
    IO.puts "Welcome #{username}"

  defp handle({:connect,username}), do:
    IO.puts "#{username} joined"

  defp handle({:say,username,message}), do:
    IO.puts "#{username}: #{message}"

  defp handle({:nick,old_username,new_username}), do:
    IO.puts "#{old_username} changed nick to #{new_username}"

end
