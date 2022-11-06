defmodule Types.NodeTree do
	defstruct [:current, next: []]
end

defimpl Protocols.Compile, for: Types.NodeTree do
	alias Types.NodeTree
	alias NodePatterns.OutputNode

	def compile(%NodeTree{current: current_node, next: next_nodes}) do
		node_call = Protocols.Compile.compile(current_node)

		if next_nodes === [] do
			{_, _, [_ | [new_node_call]]} = node_call
			quote do
				unquote(new_node_call)
			end
		else
			quote do
				unquote(node_call)

				case ctrl_code do
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
end