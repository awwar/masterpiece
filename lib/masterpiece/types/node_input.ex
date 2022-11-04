defmodule Types.NodeInput do
	defstruct [:type, :value, path: []]
end

defimpl Protocols.Compile, for: Types.NodeInput do
	alias Types.NodeInput

	def compile(%NodeInput{type: :node, value: node_reference, path: out}), do:
		quote do: ExtendMap.get_in!(
			unquote(CompilerHelper.get_node_result_variable(node_reference)),
			unquote(out)
		)

	def compile(%NodeInput{type: :value, value: value}), do:
		value

	def compile(%NodeInput{type: :object, value: object_name, path: []})
		when is_atom(object_name), do:
			Macro.var(object_name, nil)

	def compile(%NodeInput{type: :object, value: object_name, path: out})
		when is_atom(object_name), do:
			quote do: ExtendMap.get_in!(
				unquote(Macro.var(object_name, nil)),
				unquote(out)
			)
end
