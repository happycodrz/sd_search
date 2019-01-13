defmodule SdSearch.Http do
  def get(url) do
    MachineGun.get!(
      url,
      [],
      %{pool_timeout: 1000, request_timeout: 5000, pool_group: :default}
    )
  end
end
