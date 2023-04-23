defmodule :json_bool_cast_node do
  def execute(value), do: do_execute Jason.decode!(value)

  def do_execute(value) when is_boolean(value), do: {true, value}

  def do_execute(_), do: raise "Json value is not a bool"

  def get_input do
    [:value]
  end

  def get_output do
    [:value]
  end
end