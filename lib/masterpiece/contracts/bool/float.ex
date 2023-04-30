defmodule :bool_float_cast_node do
  def execute(%:bool_contract_module{value: true}), do: {true, :float_contract_module.constructor 1.0}

  def execute(%:bool_contract_module{value: false}), do: {true, :float_contract_module.constructor 0.0}

  def get_input do
    [:bool_contract_module]
  end

  def get_output do
    [:float_contract_module]
  end
end