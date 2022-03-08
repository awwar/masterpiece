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
		ordered_sockets = parsed_map
						  |> MapToGraph.execute()
						  |> Graph.postorder
						  |> Enum.reverse()
						  |> Enum.map(&{&1, sockets[&1]})

		%{
			layout_name: CompilerHelper.to_atom(layout_name),
			endpoints: EndpointParser.parse(endpoints),
			nodes: NodeParser.parse(nodes),
			map: parsed_map,
			sockets: SocketParser.parse(ordered_sockets),
		}
	end

	defp do_parse(context),
		 do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
