defmodule :integer_cm_string_cm_cast_node do
  def execute(%:integer_cm{value: value}), do: {true, :string_cm.constructor to_string(value)}

  def get_input do
    [:integer_cm]
  end

  def get_output do
    [:string_cm]
  end
end