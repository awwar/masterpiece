defmodule :json_map_cast_node do
  def execute(%:json_contract_module{value: value}), do: {true, Jason.decode!(value) |> :map_contract_module.constructor}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end