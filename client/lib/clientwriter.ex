defmodule Chat.ClientWriter do
  def run do
    spawn fn -> loop end
  end

  defp loop do
    receive do
      {:welcome,username}                -> IO.puts "Welcome #{username}"
      {:connect,username}                -> IO.puts "#{username} joined"
      {:say,username,message}            -> IO.puts "#{username}: #{message}"
      {:nick,old_username,new_username} -> IO.puts "#{old_username} changed nick to #{new_username}"
    end
    loop
  end
end
