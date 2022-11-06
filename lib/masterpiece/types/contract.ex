defmodule Types.Contract do
	defstruct [
		name: "",
		pattern: "",
		settings: %{},
	]
end

defimpl Protocols.Compile, for: Types.Contract do
	alias Types.Contract

	def compile(%Contract{}) do
	end
end
