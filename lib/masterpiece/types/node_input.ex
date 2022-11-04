defmodule Types.NodeInput do
	defstruct [:type, :value, path: []]
end

defimpl Protocols.Compile, for: Types.NodeInput do
	alias Types.NodeInput

	def compile(%NodeInput{} = value) do
		CompilerHelper.create_argument_variable(value)
	end
end