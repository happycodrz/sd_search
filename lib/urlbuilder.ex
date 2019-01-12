defmodule SdSearch.UrlBuilder do
  @moduledoc """
  curl 'https://cse.google.com/cse/element/v1?rsz=filtered_cse&num=10&hl=en&source=gcsc&gss=.com&start=130&cx=010150859881542981030:hqhxyxpwtc4&q=elixir&safe=off&cse_tok=AKaTTZhInrtYdjkwQBS-HG0qKMqK:1547254574756&sort=date&exp=csqr&callback=google.search.cse.api13312&nocache=1547254575205'   --compressed
  """
  def build(req = %SdSearch.Request{}) do
    "https://cse.google.com/cse/element/v1?rsz=filtered_cse&num=#{req.num}&hl=en&source=gcsc&gss=.com&start=#{req.start}&cx=010150859881542981030:hqhxyxpwtc4&q=#{req.q}&safe=off&cse_tok=AKaTTZhInrtYdjkwQBS-HG0qKMqK:1547254574756&sort=#{req.sort}&exp=csqr&callback=google.search.cse.api13312&nocache=1547254575205"
  end
end
