defmodule Types.NodeSocket do
	defstruct [:id, :name, :inputs]
end

defimpl Protocols.Compile, for: Types.NodeSocket do
	import CompilerHelper

	def compile(%Types.NodeSocket{name: ref, inputs: inputs}, _) do
		new_args = Enum.map(inputs, &as_ast/1)

		node_module = as_ast(ref)
		node_state_variable = node_module
							  |> Macro.var(nil)

		quote do
			{unquote({:ctrl_code, [], nil}), unquote(node_state_variable)}
			= unquote(node_module).execute(unquote_splicing(new_args))
		end
	end
end