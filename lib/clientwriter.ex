defmodule ClientWriter do
  def run do
    spawn fn -> loop end
  end

  defp loop do
    receive do
      {:welcome,userName} -> IO.puts "Welcome #{userName}"
      {:connect,userName} -> IO.puts "#{userName} joined"
      {:say,userName,message} -> IO.puts "#{userName}: #{message}"
      {:nick,oldUserName,newUserName} -> IO.puts "#{oldUserName} changed nick to #{newUserName}"
    end
    loop
  end
end
