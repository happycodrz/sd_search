defmodule SdSearch do
  @moduledoc """
  Documentation for SdSearch.
  """
  alias SdSearch.Request
  alias SdSearch.Http

  def search(q, opts \\ []) do
    res =
      Request.new(q, opts)
      |> SdSearch.UrlBuilder.build()
      |> Http.get()

    SdSearch.Result.extract(res.body)
  end
end
