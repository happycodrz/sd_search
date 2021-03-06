defmodule SdSearch.Request do
  alias SdSearch.Request
  defstruct q: nil, sort: "date", num: 10, start: 0

  def new(q, opts) do
    sort = Keyword.get(opts, :sort, "date")
    page = Keyword.get(opts, :page, 1)
    per_page = Keyword.get(opts, :per_page, 10)

    %Request{
      q: URI.encode(q),
      sort: sort,
      num: per_page,
      start: (page - 1) * per_page
    }
  end
end
