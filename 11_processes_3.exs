# In this example we use the recursion to manage multiple messages sent to the spanish_hello function.
defmodule Hello do
  def spanish_hello do
    receive do
      {sender, msg} ->
        send(sender, "Received: '#{msg}'. Thank you.")
        spanish_hello
    end
  end
end

hello_pid = spawn(Hello, :spanish_hello, [])

send(hello_pid, {self, "Here's a message for you"})
receive do
  msg -> IO.puts msg
end

send(hello_pid, {self, "Here's a message for you"})
receive do
  msg -> IO.puts msg
end
