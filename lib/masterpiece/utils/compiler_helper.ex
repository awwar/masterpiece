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

	def create_argument_variable(%Types.NodeInput{type: :node, value: node_reference, path: out}), do:
		quote do: ExtendMap.get_in!(
			unquote(get_node_result_variable(node_reference)),
			unquote(out)
		)

	def create_argument_variable(%Types.NodeInput{type: :value, value: value}), do:
		value

	def create_argument_variable(%Types.NodeInput{type: :object, value: object_name, path: []})
		when is_atom(object_name), do:
			Macro.var(object_name, nil)

	def create_argument_variable(%Types.NodeInput{type: :object, value: object_name, path: out})
		when is_atom(object_name), do:
			quote do: ExtendMap.get_in!(
				unquote(Macro.var(object_name, nil)),
				unquote(out)
			)

	def to_atom(name) when is_atom(name), do: name

	def to_atom(name), do: String.to_atom(name)
end
