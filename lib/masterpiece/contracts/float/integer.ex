defmodule :float_integer_cast_node do
  def execute(%:float_contract_module{value: value}), do: {true, :integer_contract_module.constructor trunc(value)}

  def get_input do
    [:float_contract_module]
  end

  def get_output do
    [:integer_contract_module]
  end
end