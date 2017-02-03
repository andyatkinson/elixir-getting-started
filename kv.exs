# http://elixir-lang.org/getting-started/processes.html
# process keeps map state

# Process can be registered with a name
# e.g. Process.register(pid, :kv)

defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end
