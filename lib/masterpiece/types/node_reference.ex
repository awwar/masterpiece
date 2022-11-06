defmodule Types.NodeReference do
	defstruct [:name]
end

defimpl Protocols.Compile, for: Types.NodeReference do
	alias Types.NodeReference

	def compile(%Types.NodeReference{name: node_name}) do
		"#{node_name}"
		|> String.to_atom()
	end
end
