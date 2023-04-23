defmodule :string_float_cast_node do
  def execute(value), do: {true, String.to_float(value)}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end
