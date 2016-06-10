defmodule Chat do
  def main() do
    Node.connect :'zerver@se-lpt-0002'
    client_writer = Chat.ClientWriter.run
    Chat.ClientReader.run {:global, :server}, client_writer
  end

  def start(_type, _args) do
    main()
  end

end
