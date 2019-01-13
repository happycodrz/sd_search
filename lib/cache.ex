defmodule SdSearch.Cache do
  @name :sd_search_cache
  def get(key, fun) do
    ensure_started()

    case check(key) do
      nil ->
        res = fun.()
        insert(key, res)
        res

      v ->
        v
    end
  end

  defp ensure_started do
    case :ets.info(@name) do
      :undefined -> :ets.new(@name, [:named_table, :public, read_concurrency: true])
      _ -> true
    end
  end

  def insert(k, v) do
    ensure_started()
    :ets.insert(@name, {k, v})
  end

  def check(key) do
    ensure_started()
    case :ets.lookup(@name, key) do
      [{^key, v}] -> v
      [] -> nil
    end
  end
end
