defmodule SdSearch do
  @moduledoc """
  Documentation for SdSearch.
  """
  alias SdSearch.Request
  alias SdSearch.Http

  def search(q, opts \\ []) do
    req = Request.new(q, opts)
    url = SdSearch.UrlBuilder.build(req) |> IO.inspect()
    res = Http.get(url)

    SdSearch.Result.extract(res.body)
  end
end
