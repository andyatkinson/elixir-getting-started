defmodule KV do
  use Application

  def start(_type, _args) do
    KV.Supervisor.start_link
  end

  @moduledoc """
  Documentation for KV.
  """

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello
      :world

  """
  def hello do
    :world
  end
end
