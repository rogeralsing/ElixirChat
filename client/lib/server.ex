defmodule Server do
  def connect(username, client_writer) do
    GenServer.cast({:global,:server}, {:connect,username,client_writer})
  end

  def say(username,message) do
    GenServer.cast({:global,:server}, {:say,username,message})
  end

  def nick(old_username,new_username) do
    GenServer.cast({:global,:server}, {:nick,old_username,new_username})
  end

end
