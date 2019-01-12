defmodule SdSearch do
  @moduledoc """
  Documentation for SdSearch.
  """
  alias SdSearch.Request

  def search(q, opts \\ []) do
    req = Request.new(q, opts)
    url = SdSearch.UrlBuilder.build(req) |> IO.inspect

    res = MachineGun.get!(
      url,
      [],
      %{pool_timeout: 1000, request_timeout: 5000, pool_group: :default}
    )

    SdSearch.Result.extract(res.body)
  end
end
