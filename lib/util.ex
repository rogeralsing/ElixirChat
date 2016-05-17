defmodule Util do
  def send_all clients,message do
    for client <- clients  do
      send client, message
    end
  end
end
