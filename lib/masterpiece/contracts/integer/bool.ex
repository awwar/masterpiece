defmodule :integer_cm_bool_cm_cast_node do
  def execute(%:integer_cm{value: 0}), do: {true, :bool_cm.constructor false}

  def execute(%:integer_cm{value: _}), do: {true, :bool_cm.constructor true}

  def get_input do
    [:integer_cm]
  end

  def get_output do
    [:bool_cm]
  end
end