defmodule SdSearch.UrlBuilderTest do
  use ExUnit.Case

  test "build" do

    SdSearch.Cache.insert("cse_token", "AKaTTZhInrtYdjkwQBS-HG0qKMqK:1547254574756")
    expected =
      "https://cse.google.com/cse/element/v1?rsz=filtered_cse&num=10&hl=en&source=gcsc&gss=.com&start=10&cx=010150859881542981030:hqhxyxpwtc4&q=kubernetes&safe=off&cse_tok=AKaTTZhInrtYdjkwQBS-HG0qKMqK:1547254574756&sort=date&exp=csqr&callback=google.search.cse.api13312&nocache=1547254575205"

    req = SdSearch.Request.new("kubernetes", page: 2)
    assert SdSearch.UrlBuilder.build(req) == expected
  end
end
