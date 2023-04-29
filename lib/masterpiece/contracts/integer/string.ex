defmodule :integer_string_cast_node do
  def execute(%:integer_contract_module{value: value}), do: {true, to_string(value) |> :string_contract_module.constructor}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end