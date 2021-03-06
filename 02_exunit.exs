# http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
# http://elixir-lang.org/docs/stable/ex_unit/ExUnit.html

ExUnit.start

defmodule MyTest do
  use ExUnit.Case

  test 'simple test' do
    assert 1 + 1 == 2
  end

  test 'refute is opposite of asser' do
    refute 1 + 1 == 3
  end

  test :assert_raise do
    assert_raise ArithmeticError, fn ->
      1 + "x"
    end
  end

  test "assert_in_delta asserts that val1 and val2 differ by no more than delta." do
    assert_in_delta 1,
                    5,
                    6
  end
end
