defmodule :float_cm_integer_cm_cast_node do
  def execute(%:float_cm{value: value}), do: {true, :integer_cm.constructor(trunc(value))}

  def get_input do
    [:float_cm]
  end

  def get_output do
    [:integer_cm]
  end
end
