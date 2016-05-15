defmodule Chat do
  def main() do
    server = Server.run
    clientWriter = ClientWriter.run
    ClientReader.run server, clientWriter
  end
end
