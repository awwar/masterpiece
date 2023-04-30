defmodule :integer_string_cast_node do
  def execute(%:integer_contract_module{value: value}), do: {true,  :string_contract_module.constructor to_string(value)}

  def get_input do
    [:integer_contract_module]
  end

  def get_output do
    [:string_contract_module]
  end
end