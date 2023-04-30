defmodule :bool_integer_cast_node do
  def execute(%:bool_contract_module{value: true}), do: {true, :integer_contract_module.constructor 1}

  def execute(%:bool_contract_module{value: false}), do: {true, :integer_contract_module.constructor 0}

  def get_input do
    [:bool_contract_module]
  end

  def get_output do
    [:integer_contract_module]
  end
end