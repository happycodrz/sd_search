defmodule SdSearch.UrlBuilder do
  @moduledoc """
  Makes sure we get a valid URL with a fresh token
  """
  def build(req = %SdSearch.Request{}) do
    "https://cse.google.com/cse/element/v1?rsz=filtered_cse&num=#{req.num}&hl=en&source=gcsc&gss=.com&start=#{
      req.start
    }&cx=010150859881542981030:hqhxyxpwtc4&q=#{req.q}&safe=off&cse_tok=#{cse_token()}&sort=#{
      req.sort
    }&exp=csqr&callback=google.search.cse.api13312&nocache=1547254575205"
  end

  def cse_token do
    SdSearch.GetToken.fetch()
  end
end
