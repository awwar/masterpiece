defmodule LayoutParser do
	def parse(layouts), do: Enum.map(layouts, &do_parse(&1))

	defp do_parse(
			 %{
				 "layout_name" => layout_name,
				 "endpoints" => endpoints,
				 "nodes" => nodes,
				 "map" => map,
				 "sockets" => sockets
			 }
		 ) do
		parsed_map = MapParser.parse(map)
		graph = MapToGraph.execute(parsed_map)

		%{
			layout_name: CompilerHelper.to_atom(layout_name),
			endpoints: EndpointParser.parse(endpoints),
			nodes: NodeParser.parse(nodes),
			map: parsed_map,
			graph: graph,
			sockets: SocketParser.parse(
				sockets,
				Graph.postorder(graph)
				|> Enum.reverse()
			),
		}
	end

	defp do_parse(context),
		 do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
