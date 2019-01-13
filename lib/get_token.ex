defmodule SdSearch.GetToken do
  alias SdSearch.Http
  @url "https://cse.google.com/cse.js?num=20&sa=G&hpg=1&cx=010150859881542981030:hqhxyxpwtc4"

  def fetch() do
    SdSearch.Cache.get("cse_token", &uncached_fetch/0)
  end

  def uncached_fetch do
    Http.get(@url)
    |> extract_from_body()
  end

  def extract_from_body(%{body: body}) do
    body
    |> String.split("\n")
    |> Enum.filter(fn x -> String.contains?(x, "cse_token") end)
    |> Enum.at(0)
    |> String.split("\":")
    |> Enum.at(1)
    |> String.trim()
    |> String.trim(",")
    |> String.trim("\"")
  end
end
