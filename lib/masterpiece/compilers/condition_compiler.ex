defmodule ConditionCompiler do
	alias Types.Condition
	alias Types.NodeInput
	alias Types.Expression

	def compile(%Condition{value: value}) do
		value
	end

	def compile(%NodeInput{} = value) do
		CompilerHelper.create_argument_variable(value)
	end

	def compile(%Expression{left: left, method: method, right: right}) do
		{:"#{method}", [], [compile(left), compile(right)]}
	end

	def compile(value), do: value
end
