defmodule :json_map_cast_node do
  def execute(value), do: {true, Jason.decode!(value)}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end