defmodule Bar do
  defmacro __using__(opts) do
    IO.puts "in macro"
    quote do
          import Bar
          IO.puts "in quote"
    end
  end

  def say_hello() do
    IO.puts "Hello"
  end
end

defmodule Foo do
  use Bar

  def muu() do
    say_hello()
  end
end
