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
        %{
            layout_name: String.to_atom(layout_name),
            endpoints: EndpointParser.parse(endpoints),
            nodes: NodeParser.parse(nodes),
            sockets: SocketParser.parse(sockets)
            #            map: MapParser.parse(map),
        }
    end

    defp do_parse(context),
         do: raise "Unexpected layout context, got: " <> Kernel.inspect(context)
end
