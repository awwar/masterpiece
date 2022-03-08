defmodule FlowParser do
	def parse(layouts), do: Enum.map(layouts, &do_parse(&1))

	defp do_parse(
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
		graph = MapToGraph.execute(parsed_map)

		%{
			flow_name: CompilerHelper.to_atom(flow_name),
			nodes: NodeParser.parse(nodes),
			map: parsed_map,
			sockets: SocketParser.parse(
				sockets,
				Graph.postorder(graph)
				|> Enum.reverse()
			),
			input: Enum.map(input, &Macro.var(String.to_atom(&1), nil)),
			output: Enum.map(output, &String.to_atom(&1))
		}
	end

	defp do_parse(context),
		 do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
