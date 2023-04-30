defmodule :float_bool_cast_node do
  def execute(%:float_contract_module{value: 0.0}), do: {true, :bool_contract_module.constructor false}

  def execute(%:float_contract_module{value: _}), do: {true, :bool_contract_module.constructor true}

  def get_input do
    [:float_contract_module]
  end

  def get_output do
    [:bool_contract_module]
  end
end