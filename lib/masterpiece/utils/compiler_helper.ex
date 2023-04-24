defmodule CompilerHelper do
	def to_atom(name) when is_atom(name), do: name

	def to_atom(name), do: String.to_atom(name)

	defdelegate as_ast(value), to: Protocols.Compile, as: :compile
  defdelegate as_ast(value, context), to: Protocols.Compile, as: :compile
end
