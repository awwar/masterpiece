defmodule :float_integer_cast_node do
  def execute(value), do: {true, trunc(value)}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end