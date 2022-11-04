defmodule CompilerHelper do
	def get_node_result_variable(%Types.NodeReference{name: node_name}) do
		node_name
		|> then(&to_atom("#{&1}_result"))
		|> Macro.var(nil)
	end

	def get_node_result_variable(node_name) when is_atom(node_name) do
		node_name
		|> then(&to_atom("#{&1}_result"))
		|> Macro.var(nil)
	end

	def to_atom(name) when is_atom(name), do: name

	def to_atom(name), do: String.to_atom(name)
end
