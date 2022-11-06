defmodule Types.Expression do
	defstruct [:left, :method, :right]
end

defimpl Protocols.Compile, for: Types.Expression do
	alias Types.Expression
	import CompilerHelper

	def compile(%Expression{left: left, method: method, right: right}) do
		{:"#{method}", [], [as_ast(left), as_ast(right)]}
	end
end
