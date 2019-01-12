defmodule SdSearch.ResultTest do
  use ExUnit.Case
  alias SdSearch.Result

  def fixture(name) do
    File.read!("test/fixtures/#{name}")
  end

  describe "strip_js" do
    test "works fine" do
      {:ok, r} = Result.strip_js(fixture("result1.txt"))
      refute r =~ Regex.compile!("/*O_o*/")
      assert String.slice(r, -1, 1) == "}"
    end
  end

  describe "extract" do
    test "works" do
      {:ok, res} = Result.extract(fixture("result1.txt"))
      # IO.inspect res
    end
  end
end
