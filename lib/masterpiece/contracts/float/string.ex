defmodule :float_cm_string_cm_cast_node do
  def execute(%:float_cm{value: value}), do: {true, :string_cm.constructor to_string(value)}

  def get_input do
    [:float_cm]
  end

  def get_output do
    [:string_cm]
  end
end