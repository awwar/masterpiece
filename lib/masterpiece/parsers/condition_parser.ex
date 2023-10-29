defmodule ConditionParser do
  alias Types.Condition
  alias Types.Expression

  @methods ["===", ">", "<", ">=", "<=", "/", "*", "+", "-", "^"]

  def parse(value) when is_binary(value) or is_boolean(value) or is_number(value),
    do: %Condition{value: value}

  def parse(context) when is_map(context), do: NodeInputParser.parse(context)

  def parse([left, method, right]) when method in @methods,
    do: %Expression{left: parse(left), method: method, right: parse(right)}
end
