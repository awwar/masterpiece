defmodule :integer_json_cast_node do
  def execute(value), do: {true, Jason.encode!(value)}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end