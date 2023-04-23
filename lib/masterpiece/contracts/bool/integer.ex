defmodule :bool_integer_cast_node do
  def execute(true), do: {true, 1}
  def execute(false), do: {true, 0}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end