defmodule :string_integer_cast_node do
  def execute(%:string_contract_module{value: value}), do: {true, :integer_contract_module.constructor String.to_integer(value)}

  def get_input do
    [:string_contract_module]
  end

  def get_output do
    [:integer_contract_module]
  end
end