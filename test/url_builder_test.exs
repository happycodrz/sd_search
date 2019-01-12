defmodule SdSearch.UrlBuilderTest do
  use ExUnit.Case
  test "build" do
    req = SdSearch.Request.new("kubernetes", page: 2)
    SdSearch.UrlBuilder.build(req) |> IO.inspect
  end
end
