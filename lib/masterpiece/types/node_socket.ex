defmodule Types.NodeSocket do
	defstruct [:id, :name, :inputs]
end

defimpl Protocols.Compile, for: Types.NodeSocket do
	alias Types.NodeSocket

	def compile(%NodeSocket{name: ref, inputs: inputs}) do
		new_args = Enum.map(inputs, &Protocols.Compile.compile/1)

		node_module = Protocols.Compile.compile(ref)
		node_state_variable = node_module
							  |> Macro.var(nil)

		quote do
			{unquote({:ctrl_code, [], nil}), unquote(node_state_variable)}
			= unquote(node_module).execute(unquote_splicing(new_args))
		end
	end
end