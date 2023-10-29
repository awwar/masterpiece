defmodule :string_cm_float_cm_cast_node do
  def execute(%:string_cm{value: value}),
    do: {true, :float_cm.constructor(String.to_float(value))}

  def get_input do
    [:string_cm]
  end

  def get_output do
    [:float_cm]
  end
end
