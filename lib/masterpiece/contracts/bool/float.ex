defmodule :bool_cm_float_cm_cast_node do
  def execute(%:bool_cm{value: true}), do: {true, :float_cm.constructor(1.0)}

  def execute(%:bool_cm{value: false}), do: {true, :float_cm.constructor(0.0)}

  def get_input do
    [:bool_cm]
  end

  def get_output do
    [:float_cm]
  end
end
