defmodule :string_float_cast_node do
  def execute(%:string_contract_module{value: value}), do: {true, :float_contract_module.constructor String.to_float(value)}

  def get_input do
    [:string_contract_module]
  end

  def get_output do
    [:float_contract_module]
  end
end
