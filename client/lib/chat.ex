defmodule Chat do
  def start(_type, _args) do
    Node.connect :'zerver@se-lpt-0002'
    :global.sync()
    client_writer = Chat.ClientWriter.run
    Chat.ClientReader.run client_writer
  end
end
