defmodule SdSearch.ResultItem do
  alias __MODULE__
  defstruct [:url, :title, :description]

  @doc """
  %{
      "cacheUrl" => "http://www.google.com/search?q=cache:RxMSiry-UdEJ:speakerdeck.com",
      "clicktrackUrl" => "https://www.google.com/url?q=https://speakerdeck.com/keathley/building-resilient-elixir-systems&sa=U&ved=0ahUKEwjpkN2-uOjfAhUKZVAKHdKzA3E4ChAWCAUwAA&client=internal-uds-cse&cx=010150859881542981030:hqhxyxpwtc4&usg=AOvVaw3-LcBImMOslNk8NHWMPkwi",
      "content" => "Oct 26, 2018 <b>...</b> This was my attempt at describing a methodology for building systems in <b>elixir</b> \nthat can handle failures at all levels. It touches on technology&nbsp;...",
      "contentNoFormatting" => "Oct 26, 2018 ... This was my attempt at describing a methodology for building systems in elixir \nthat can handle failures at all levels. It touches on technology ...",
      "formattedUrl" => "https://speakerdeck.com/keathley/building-resilient-<b>elixir</b>-systems",
      "richSnippet" => %{
        "cseImage" => %{
          "src" => "https://secure.gravatar.com/avatar/06f8b41980eb4c577fa40c41d5030c19?s=128"
        },
        "cseThumbnail" => %{
          "height" => "128",
          "src" => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8jDLLVY1QvJhF2kLb-TyvrLv9JBpwsJqFsDnjSMykK_SNhHKrmNcx_S6S",
          "width" => "128"
        },
        "metatags" => %{
          "csrfParam" => "authenticity_token",
          "csrfToken" => "BQI0hAroAiUSWKm9Z8VC8hoAo0DApMQwNFpQIY5yiHlsq9JRBJ0fdU9v06LlAigf3FsKiF3BTjAqiqa1fXLMpw==",
          "ogAuthor" => "https://www.facebook.com/SpeakerDeck",
          "ogDescription" => "Presented at GigCity Elixir - 2018\r\n\r\nThis was my attempt at describing a methodology for building systems in elixir that can handle failures at all levels. It touches on technology solutions as well as how to engage humans in those solutions.",
          "ogImage" => "https://speakerd.s3.amazonaws.com/presentations/ee1735a8f9bd42ff8d4938975c9827dc/slide_0.jpg?472525",
          "ogSiteName" => "Speaker Deck",
          "ogTitle" => "Building Resilient Elixir Systems",
          "ogType" => "website",
          "ogUrl" => "https://speakerdeck.com/keathley/building-resilient-elixir-systems",
          "statsOwnerId" => "125799",
          "statsTalkId" => "472782",
          "statsViewType" => "talk",
          "twitterCard" => "summary_large_image",
          "twitterCreator" => "@speakerdeck",
          "twitterDescription" => "Presented at GigCity Elixir - 2018\r\n\r\nThis was my attempt at describing a methodology for building systems in elixir that can handle failures at all levels. It touches on technology solutions as well as how to engage humans in those solutions.",
          "twitterImageSrc" => "https://speakerd.s3.amazonaws.com/presentations/ee1735a8f9bd42ff8d4938975c9827dc/slide_0.jpg?472525",
          "twitterSite" => "@speakerdeck",
          "twitterTitle" => "Building Resilient Elixir Systems",
          "viewport" => "width=device-width, initial-scale=1, user-scalable=no, viewport-fit=cover"
        }
      },
      "title" => "Building Resilient <b>Elixir</b> Systems - Speaker Deck",
      "titleNoFormatting" => "Building Resilient Elixir Systems - Speaker Deck",
      "unescapedUrl" => "https://speakerdeck.com/keathley/building-resilient-elixir-systems",
      "url" => "https://speakerdeck.com/keathley/building-resilient-elixir-systems",
      "visibleUrl" => "speakerdeck.com"
    }
  """
  def from_google(item) do
    %ResultItem{
      description: item |> get_in(["richSnippet", "metatags", "twitterDescription"]),
      title: item |> get_in(["richSnippet", "metatags", "twitterTitle"]),
      url: item |> Map.get("unescapedUrl")
    }
  end
end

defmodule SdSearch.Result do
  def extract(text) do
    with {:ok, r} <- strip_js(text),
         {:ok, res} <- Jason.decode(r) do
      {:ok, remap_items(res)}
    end
  end

  def strip_js("/*O_o*/\n" <> text) do
    text |> strip_js()
  end

  def strip_js("google.search.cse.api13312(" <> text) do
    size = String.length(text)
    {:ok, String.slice(text, 0, size - 2)}
  end

  def remap_items(res = %{"results" => results}) do
    results = results |> Enum.map(&SdSearch.ResultItem.from_google/1)

    res |> Map.put("results", results)
  end
end
