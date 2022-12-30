defmodule FlowParser do
	alias Types.Flow
	alias Types.LogicCondition
	alias Types.LogicConnection
	alias Types.SocketReference

	def parse(flows) when is_list(flows), do: Enum.map(flows, &parse(&1))

	def parse(
			%{
				"flow_name" => flow_name,
				"nodes" => nodes,
				"map" => map,
				"sockets" => sockets,
				"input" => input,
				"output" => output
			}
		) do
		parsed_map = MapParser.parse(map)
		ordered_sockets = parsed_map
						  |> MapToGraph.execute()
						  |> Graph.postorder
						  |> Enum.reverse()
						  |> Enum.map(&{&1, sockets[&1]})
						  |> SocketParser.parse

		%Flow{
			flow_name: CompilerHelper.to_atom(flow_name),
			nodes: NodeParser.parse(nodes),
			tree: List.first(ordered_sockets)
				  |> node_tree(parsed_map, ordered_sockets),
			input: NamedContractParser.parse(input),
			output: NamedContractParser.parse(output),
		}
	end

	def parse(context),
		do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)

	defp node_tree(%_{id: id} = node, map, sockets) do
		next_nodes = next_nodes(id, map, sockets)

		%Types.NodeTree{
			current: node,
			next: Enum.map(next_nodes, fn {condition, socket} -> {condition, node_tree(socket, map, sockets)} end)
		}
	end

	defp next_nodes(id, map, sockets) do
		Enum.filter(map, fn %LogicConnection{from_id: from_id} -> from_id === id end)
		|> Enum.map(fn %LogicConnection{condition: condition} -> condition end)
		|> Enum.map(
			   fn %LogicCondition{
					  to_id: to_id,
					  condition: condition
				  } -> {condition, get_compliance_node(to_id, sockets)}
			   end
		   )
	end

	defp get_compliance_node(to_id, sockets),
		 do: Enum.find(
			 sockets,
			 fn %_{id: id} ->
				 SocketReference.to_binary(id) === SocketReference.to_binary(to_id)
			 end
		 )
end
