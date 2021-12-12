defmodule Types.NodeReference do
	defstruct [:name]

	def from_binary(name) when is_binary(name), do: %Types.NodeReference{name: name}

	def to_binary(%Types.NodeReference{name: name}) when is_binary(name), do: name
end
