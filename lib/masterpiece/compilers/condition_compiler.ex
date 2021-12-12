defmodule ConditionCompiler do
	alias Types.Condition
	alias Types.NodeInput
	alias Types.Expression

	def compile(value) do
		quote do: unquote(get_value(value))
	end

	defp get_value(%Condition{value: value}) do
		value
	end

	defp get_value(%NodeInput{} = value) do
		CompilerHelper.create_argument_variable(value)
	end

	defp get_value(%Expression{left: left, method: method, right: right}) do
		{:"#{method}", [], [get_value(left), get_value(right)]}
	end

	defp get_value(value), do: value
end
