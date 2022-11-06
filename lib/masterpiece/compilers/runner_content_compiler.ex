defmodule RunnerContentCompiler do
	alias Types.Condition
	alias Types.LogicCondition
	alias Types.LogicConnection
	alias Types.NodeReference
	alias Types.NodeSocket
	alias Types.ScopeSocket
	alias Types.SocketReference

	def compile(sockets, map) do
		root = List.first(sockets)

		get_node_resolver(root, map, sockets)
	end

	defp get_node_resolver(%NodeSocket{id: id, name: ref, inputs: inputs}, map, sockets) do
		node_name = NodeReference.to_atom(ref)

		next_nodes_resolver = get_next(id, map, sockets)

		new_args = Enum.map(inputs, &Protocols.Compile.compile/1)

		node_call = quote do: unquote(node_name).execute(unquote_splicing(new_args))

		if next_nodes_resolver === [] do
			quote do
				unquote(node_call)
			end
		else
			node_state_variable = CompilerHelper.get_node_result_variable(node_name)
			quote do
				{ctrl_code, unquote(node_state_variable)} = unquote(node_call)

				case ctrl_code do
					unquote(Enum.map(next_nodes_resolver, fn {f, n} -> {:->, [], [[f], n]} end))
				end
			end
		end
	end

	defp get_node_resolver(%ScopeSocket{id: id, scope: scope, options: options}, map, sockets) do
		next_nodes_resolver = get_next(id, map, sockets)

		if next_nodes_resolver === [], do: raise "Scope can't be a leaf of a socket tree!"

		node_call = scope.get_content(options)
		quote do
			ctrl_code = unquote(node_call)
			case ctrl_code do
				unquote(Enum.map(next_nodes_resolver, fn {f, n} -> {:->, [], [[f], n]} end))
			end
		end
	end

	defp get_next(id, map, sockets) do
		Enum.filter(map, fn %LogicConnection{from_id: from_id} -> from_id === id end)
		|> Enum.map(fn %LogicConnection{condition: condition} -> condition end)
		|> Enum.map(
			   fn %LogicCondition{
					  to_id: to_id,
					  condition: %Condition{
						  value: value
					  }
				  } -> {value, get_compliance_node(to_id, sockets)}
			   end
		   )
		|> Enum.map(fn {f, n} -> {f, get_node_resolver(n, map, sockets)} end)
	end

	defp get_compliance_node(to_id, sockets),
		 do: Enum.find(
			 sockets,
			 fn %_{id: id} ->
				 SocketReference.to_binary(id) === SocketReference.to_binary(to_id)
			 end
		 )
end
