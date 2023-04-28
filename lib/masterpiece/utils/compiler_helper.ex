defmodule CompilerHelper do
  def to_atom(name) when is_atom(name), do: name

  def to_atom(name), do: String.to_atom(name)

  def as_ast(value), do: Protocols.Compile.compile(value, %{})
  def as_ast(value, context), do: Protocols.Compile.compile(value, context)
end
