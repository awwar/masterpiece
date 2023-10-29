defmodule :json_cm_map_cm_cast_node do
  def execute(%:json_cm{value: value}), do: {true, :map_cm.constructor(Jason.decode!(value))}

  def get_input do
    [:json_cm]
  end

  def get_output do
    [:map_cm]
  end
end
