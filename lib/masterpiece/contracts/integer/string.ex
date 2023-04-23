defmodule :integer_string_cast_node do
  def execute(value), do: {true, to_string(value)}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end