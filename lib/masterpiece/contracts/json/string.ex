defmodule :json_cm_string_cm_cast_node do
  def execute(%:json_cm{value: value}), do: {true, :string_cm.constructor value}

  def get_input do
    [:json_cm]
  end

  def get_output do
    [:string_cm]
  end
end