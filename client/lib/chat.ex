defmodule Chat do
  def start(_type, _args) do
    Node.connect :'zerver@se-lpt-0002'
    :global.sync()

    Chat.ClientReader.run("Roger", Chat.ClientWriter.run)
  end
end
