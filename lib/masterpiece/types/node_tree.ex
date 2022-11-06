defmodule Types.NodeTree do
	defstruct [:current, next: []]
end

defimpl Protocols.Compile, for: Types.NodeTree do
	alias Types.NodeTree
	alias NodePatterns.OutputNode

	def compile(%NodeTree{current: current_node, next: []}) do
		{_, _, [_ | [node_call]]} = Protocols.Compile.compile(current_node)

		quote do
			unquote(node_call)
		end
	end

	def compile(%NodeTree{current: current_node, next: next_nodes}) do
		node_call = Protocols.Compile.compile(current_node)

		quote do
			unquote(node_call)

			case unquote({:ctrl_code, [], nil}) do
				unquote(
					Enum.map(
						next_nodes,
						fn {f, n} -> {:->, [], [[Protocols.Compile.compile(f)], Protocols.Compile.compile(n)]} end
					)
				)
			end
		end
	end
end