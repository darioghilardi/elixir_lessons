defmodule Fibonacci do
  @moduledoc """
  Fibonacci example that returns only the number at the param position.
  """
  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)
end

defmodule FibonacciList do
  @moduledoc """
  Fibonacci example that returns a list param numbers.
  """
  def fib(0), do: []
  def fib(1), do: [1]
  def fib(2), do: [1, 1]
  def fib(n), do: fib(n-1) ++ [(List.last(fib(n-1)) + List.last(fib(n-2)))]
end

defmodule FasterFibonacciList do
  @moduledoc """
  Fibonacci example that returns a list param numbers.
  """
  def fib(0), do: []
  def fib(1), do: [1]
  def fib(2), do: [1, 1]
  def fib(n), do: fib(n-1) ++ [_fib(n-1)]

  def _fib(0), do: 1
  def _fib(1), do: 1
  def _fib(n), do: _fib(n-1) + _fib(n-2)
end

defmodule ReallyFasterFibonacciList do
  @moduledoc """
  Faster Fibonacci example using tail recursion.
  """
  def fib(n) do
    Enum.map(0..n, fn(x) -> _fib(x) end)
  end

  def _fib(n, current \\ 0, sum \\ 1)

  def _fib(0, _, sum) do
    sum
  end

  def _fib(n, current, sum) do
    _fib(n-1, sum, sum + current)
  end
end

ExUnit.start

defmodule RecursionTest do
  use ExUnit.Case

  test "Fibonacci" do
    assert Fibonacci.fib(0) == 1
    assert Fibonacci.fib(1) == 1
    assert Fibonacci.fib(2) == 2
    assert Fibonacci.fib(3) == 3
    assert Fibonacci.fib(4) == 5
    assert Fibonacci.fib(5) == 8
    assert Fibonacci.fib(6) == 13
    assert Fibonacci.fib(7) == 21
  end

  test "FibonacciList" do
    assert FibonacciList.fib(0) == []
    assert FibonacciList.fib(1) == [1]
    assert FibonacciList.fib(2) == [1, 1]
    assert FibonacciList.fib(3) == [1, 1, 2]
    assert FibonacciList.fib(4) == [1, 1, 2, 3]
    assert FibonacciList.fib(5) == [1, 1, 2, 3, 5]
    assert FibonacciList.fib(6) == [1, 1, 2, 3, 5, 8]
    assert FibonacciList.fib(7) == [1, 1, 2, 3, 5, 8, 13]
    assert FibonacciList.fib(8) == [1, 1, 2, 3, 5, 8, 13, 21]
  end

  test "FasterFibonacciList" do
    assert FasterFibonacciList.fib(0) == []
    assert FasterFibonacciList.fib(1) == [1]
    assert FasterFibonacciList.fib(2) == [1, 1]
    assert FasterFibonacciList.fib(3) == [1, 1, 2]
    assert FasterFibonacciList.fib(4) == [1, 1, 2, 3]
    assert FasterFibonacciList.fib(5) == [1, 1, 2, 3, 5]
    assert FasterFibonacciList.fib(6) == [1, 1, 2, 3, 5, 8]
    assert FasterFibonacciList.fib(7) == [1, 1, 2, 3, 5, 8, 13]
    assert FasterFibonacciList.fib(8) == [1, 1, 2, 3, 5, 8, 13, 21]
  end

  test "ReallyFasterFibonacciList" do
    assert ReallyFasterFibonacciList.fib(0) == [1]
    assert ReallyFasterFibonacciList.fib(1) == [1, 1]
    assert ReallyFasterFibonacciList.fib(2) == [1, 1, 2]
    assert ReallyFasterFibonacciList.fib(3) == [1, 1, 2, 3]
    assert ReallyFasterFibonacciList.fib(4) == [1, 1, 2, 3, 5]
    assert ReallyFasterFibonacciList.fib(5) == [1, 1, 2, 3, 5, 8]
    assert ReallyFasterFibonacciList.fib(6) == [1, 1, 2, 3, 5, 8, 13]
    assert ReallyFasterFibonacciList.fib(7) == [1, 1, 2, 3, 5, 8, 13, 21]
  end

  test "benchmark" do
    {microsecs, _} = :timer.tc fn -> FibonacciList.fib(20) end
    IO.puts "List created using FibonacciList in #{microsecs} microsecs."

    {microsecs, _} = :timer.tc fn -> FasterFibonacciList.fib(20) end
    IO.puts "List created using FasterFibonacciList in #{microsecs} microsecs."

    {microsecs, _} = :timer.tc fn -> ReallyFasterFibonacciList.fib(20) end
    IO.puts "List created using ReallyFasterFibonacciList in #{microsecs} microsecs."
  end
end
