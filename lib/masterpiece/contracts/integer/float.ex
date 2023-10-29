defmodule :integer_cm_float_cm_cast_node do
  def execute(%:integer_cm{value: value}), do: {true, :float_cm.constructor(value + 0.0)}

  def get_input do
    [:integer_cm]
  end

  def get_output do
    [:float_cm]
  end
end
