defmodule FlowParser do
	alias Types.Flow

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
			map: parsed_map,
			sockets: ordered_sockets,
			input: Enum.map(input, &String.to_atom(&1)),
			output: Enum.map(output, &String.to_atom(&1))
		}
	end

	def parse(context),
		do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
