defmodule Hello do
  def spanish_hello do
    receive do
      {sender, msg} ->
        send(sender, "Received: '#{msg}'. Thank you.")
    end
  end
end

hello_pid = spawn(Hello, :spanish_hello, [])
send(hello_pid, {self, "Here's a message for you"})

receive do
  msg -> IO.puts msg
end

# In this example we spawn a new process and collect its pid.
# Then we send a message to the spanish_hello function, as the new process.
# The new process executes the receive and send back to the parent process the message,
# which is printed with the receive at line 14.
