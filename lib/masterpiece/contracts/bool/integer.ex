defmodule :bool_cm_integer_cm_cast_node do
  def execute(%:bool_cm{value: true}), do: {true, :integer_cm.constructor 1}

  def execute(%:bool_cm{value: false}), do: {true, :integer_cm.constructor 0}

  def get_input do
    [:bool_cm]
  end

  def get_output do
    [:integer_cm]
  end
end