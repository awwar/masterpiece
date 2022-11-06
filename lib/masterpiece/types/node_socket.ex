defmodule Types.NodeSocket do
	defstruct [:id, :name, :inputs]
end

defimpl Protocols.Compile, for: Types.NodeSocket do
	alias Types.NodeSocket
	alias Types.NodeReference

	def compile(%NodeSocket{id: id, name: ref, inputs: inputs}) do
		node_name = NodeReference.to_atom(ref)

		new_args = Enum.map(inputs, &Protocols.Compile.compile/1)

		node_call = quote do: unquote(node_name).execute(unquote_splicing(new_args))

		node_state_variable = CompilerHelper.get_node_result_variable(node_name)

		quote do
			{ctrl_code, unquote(node_state_variable)} = unquote(node_call)
		end
	end
end