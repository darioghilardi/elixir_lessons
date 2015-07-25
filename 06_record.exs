# http://elixir-lang.org/docs/v1.0/elixir/Record.html
# http://elixir-lang.org/getting-started/structs.html

ExUnit.start

defmodule User do
  defstruct email: nil, password: nil
end

defimpl String.Chars, for: User do
  def to_string(%User{email: email}) do
    email
  end
end

defmodule RecordTest do
  use ExUnit.Case

  # Testing records
  defmodule ScopeTest do
    use ExUnit.Case

    require Record
    Record.defrecordp :person, first_name: :nil, last_name: nil, age: nil

    test "defrecordp" do
      p = person(first_name: "Kai", last_name: "Morgan", age: 5)
      assert p == {:person, "Kai", "Morgan", 5}
    end
  end

  # Testing structs
  def sample do
    %User{email: "kay@example.com", password: "trains"}
  end

  test "defstruct" do
    assert sample == %{__struct__: User, email: "kay@example.com", password: "trains"}
  end

  test "property" do
    assert sample.email == "kay@example.com"
  end

  test "update" do
    u = sample
    u2 = %User{u | email: "tim@example.com"}
    assert u2 == %User{email: "tim@example.com", password: "trains"}
  end

  test "protocol" do
    assert to_string(sample) == "kay@example.com"
  end
end
