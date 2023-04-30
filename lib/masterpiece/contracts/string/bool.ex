defmodule :string_bool_cast_node do
  def execute(%:string_contract_module{value: ""}), do: {true, :bool_contract_module.constructor false}

  def execute(%:string_contract_module{value: _}), do: {true, :bool_contract_module.constructor true}

  def get_input do
    [:string_contract_module]
  end

  def get_output do
    [:bool_contract_module]
  end
end
