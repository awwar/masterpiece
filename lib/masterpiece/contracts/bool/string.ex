defmodule :bool_string_cast_node do
  def execute(%:bool_contract_module{value: value}), do: {true, :string_contract_module.constructor to_string(value)}

  def get_input do
    [:bool_contract_module]
  end

  def get_output do
    [:string_contract_module]
  end
end