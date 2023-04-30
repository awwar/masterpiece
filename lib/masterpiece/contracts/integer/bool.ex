defmodule :integer_bool_cast_node do
  def execute(%:integer_contract_module{value: 0}), do: {true, :bool_contract_module.constructor false}

  def execute(%:integer_contract_module{value: _}), do: {true, :bool_contract_module.constructor true}

  def get_input do
    [:integer_contract_module]
  end

  def get_output do
    [:bool_contract_module]
  end
end