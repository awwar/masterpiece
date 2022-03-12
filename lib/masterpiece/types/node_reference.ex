defmodule Types.NodeReference do
	defstruct [:name]

	def from_binary(name) when is_binary(name), do: %Types.NodeReference{name: name}

	def to_atom(%Types.NodeReference{name: name}) when is_atom(name), do: name

	def to_atom(%Types.NodeReference{name: name}) when is_binary(name), do: String.to_atom(name)
end
