defmodule Hello do
  def spanish(msg) do
    IO.puts "Hola! #{msg}"
  end
end

IO.puts "Parent process is #{inspect self}"
IO.puts "Spawned process is #{inspect spawn(Hello, :spanish, ["This is Elixir"])}"
