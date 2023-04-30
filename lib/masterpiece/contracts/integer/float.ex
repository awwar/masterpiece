defmodule :integer_float_cast_node do
  def execute(%:integer_contract_module{value: value}), do: {true, :float_contract_module.constructor value + 0.0}

  def get_input do
    [:integer_contract_module]
  end

  def get_output do
    [:float_contract_module]
  end
end