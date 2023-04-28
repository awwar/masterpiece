defmodule Types.NodeTree do
	defstruct [:current, next: []]
end

defimpl Protocols.Compile, for: Types.NodeTree do
	alias Types.NodeTree
	import CompilerHelper

	def compile(%NodeTree{current: current_node, next: []}, _) do
		{_, _, [_ | [node_call]]} = as_ast(current_node)

		quote do
			unquote(node_call)
		end
	end

	def compile(%NodeTree{current: current_node, next: next_nodes}, _) do
		node_call = as_ast(current_node)

		quote do
			unquote(node_call)

			case unquote({:ctrl_code, [], nil}) do
				unquote(
					Enum.map(
						next_nodes,
						fn {f, n} -> {:->, [], [[as_ast(f)], as_ast(n)]} end
					)
				)
			end
		end
	end
end