defmodule Types.Expression do
	defstruct [:left, :method, :right]
end

defimpl Protocols.Compile, for: Types.Expression do
	alias Types.Expression

	def compile(%Expression{left: left, method: method, right: right}) do
		{:"#{method}", [], [Protocols.Compile.compile(left), Protocols.Compile.compile(right)]}
	end
end