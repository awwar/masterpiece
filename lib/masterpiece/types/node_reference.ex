defmodule Types.NodeReference do
	defstruct [:name]
end

defimpl Protocols.Compile, for: Types.NodeReference do
	def compile(%Types.NodeReference{name: node_name}, _) do
		"#{node_name}"
		|> String.to_atom()
	end
end
