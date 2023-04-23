defmodule :json_string_cast_node do
  def execute(value), do: {true, value}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end