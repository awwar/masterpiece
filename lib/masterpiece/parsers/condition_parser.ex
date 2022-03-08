defmodule ConditionParser do
	alias Types.Expression
	alias Types.Condition

	@methods ["===", ">", "<", ">=", "<=", "/", "*", "+", "-", "^"]

	def parse(cond) when is_binary(cond) or is_boolean(cond) or is_number(cond),
		do: %Condition{value: cond}

	def parse(%{"path" => _} = context), do: NodeInputParser.parse(context)

	def parse([left, method, right]) when method in @methods,
		do: %Expression{left: parse(left), method: method, right: parse(right)}
end
