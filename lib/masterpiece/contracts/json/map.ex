defmodule :json_map_cast_node do
  def execute(%:json_contract_module{value: value}), do: {true, :map_contract_module.constructor Jason.decode!(value)}

  def get_input do
    [:json_contract_module]
  end

  def get_output do
    [:map_contract_module]
  end
end