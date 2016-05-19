defmodule Chat do
  def main() do
    server = Chat.Server.run
    client_writer = Chat.ClientWriter.run
    Chat.ClientReader.run server, client_writer
  end
end
