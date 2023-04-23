defmodule :integer_bool_cast_node do
  def execute(0), do: {true, false}
  def execute(_), do: {true, true}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end