defmodule :string_cm_integer_cm_cast_node do
  def execute(%:string_cm{value: value}),
    do: {true, :integer_cm.constructor(String.to_integer(value))}

  def get_input do
    [:string_cm]
  end

  def get_output do
    [:integer_cm]
  end
end
