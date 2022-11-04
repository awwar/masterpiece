defmodule Types.Condition do
	defstruct [:value]
end

defimpl Protocols.Compile, for: Types.Condition do
	alias Types.Condition

	def compile(%Condition{value: value}) do
		value
	end
end