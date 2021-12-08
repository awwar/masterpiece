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
            layout_name: String.to_atom(layout_name),
            endpoints: EndpointParser.parse(endpoints),
            nodes: NodeParser.parse(nodes),
            sockets: SocketParser.parse(sockets),
            map: parsed_map,
            graph: graph,
            root: Graph.arborescence_root(graph)
        }
    end

    defp do_parse(context),
         do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
