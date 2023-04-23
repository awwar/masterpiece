defmodule :integer_float_cast_node do
  def execute(value), do: {true, value + 0.0}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end