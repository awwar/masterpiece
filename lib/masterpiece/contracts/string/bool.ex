defmodule :string_bool_cast_node do
  def execute(""), do: {true, false}

  def execute(_), do: {true, true}

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end
