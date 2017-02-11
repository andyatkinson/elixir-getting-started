defmodule Math do
  @moduledoc """
  Provides math related functions

  ## Examples
  # iex> Math.sum(1, 2)
  #       3
  """

  @doc """
  Calculates the sum of two numbers
  """
  def sum(a, b) do
    a + b
  end

  # http://elixir-lang.org/getting-started/recursion.html
  # reduce algorithm
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end

  # map algorithm
  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

#IO.puts Math.sum(1,2)

#IO.puts Math.sum_list([1,2,3], 0)

IO.puts Math.double_each([1,2,3])

# double_each [1 * 2 | double_each [2 * 2] | double_each [3 * 2]]
# [2,4,6]

# Can be written using the Enum module

# Enum.reduce([1,2,3], 0, fn(x, acc) -> x + acc end)

#Enum.map([1,2,3], fn(x) -> x * 2 end)
