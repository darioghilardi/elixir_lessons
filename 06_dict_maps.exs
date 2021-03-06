# http://elixir-lang.org/docs/stable/elixir/Dict.html
# http://elixir-lang.org/docs/stable/elixir/Map.html

ExUnit.start

defmodule MapTest do
  use ExUnit.Case

  def sample do
    %{foo: 'bar', baz: 'quz'}
  end

  test 'Map.get' do
    assert Map.get(sample, :foo) == 'bar'
    assert Map.get(sample, :non_existent) == nil
  end

  test '[]' do
    assert sample[:foo] == 'bar'
    assert sample[:non_existent] == nil
  end

  test "." do
    assert sample.foo == 'bar'
    assert_raise KeyError, fn ->
      sample.non_existent
    end
  end

  test "Map.fetch" do
    {:ok, val} = Map.fetch(sample, :foo)
    assert val == 'bar'
    assert :error == Map.fetch(sample, :non_existent)
  end

  test "Map.put" do
    assert Map.put(sample, :foo, 'bob') == %{foo: 'bob', baz: 'quz'}
    assert Map.put(sample, :far, 'bar') == %{foo: 'bar', baz: 'quz', far: 'bar'}
  end

  test "Map.values" do
    assert Enum.sort(Map.values(sample)) == ['bar', 'quz']
  end
end

defmodule SpeedTest do
  use ExUnit.Case

  test "HashDict speed" do
    {microsec, _} = :timer.tc fn ->
      Enum.reduce 1..1_000_000, HashDict.new, fn (i,d) ->
        Dict.put d, i, 'foo'
      end
    end
    IO.puts "HashDict tool #{microsec} microsecs"
  end

  test "Maps speed" do
    {microsec, _} = :timer.tc fn ->
      Enum.reduce 1..1_000_000, Map.new, fn (i,d) ->
        Map.put d, i, 'foo'
      end
    end
    IO.puts "Map took #{microsec} microsecs"
  end
end
