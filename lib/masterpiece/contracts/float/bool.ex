defmodule :float_cm_bool_cm_cast_node do
  def execute(%:float_cm{value: 0.0}), do: {true, :bool_cm.constructor(false)}

  def execute(%:float_cm{value: _}), do: {true, :bool_cm.constructor(true)}

  def get_input do
    [:float_cm]
  end

  def get_output do
    [:bool_cm]
  end
end
