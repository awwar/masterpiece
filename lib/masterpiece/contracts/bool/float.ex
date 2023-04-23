defmodule :bool_float_cast_node do
  def execute(true), do: {true, 1.0}
  def execute(false), do: {true, 0.0}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end