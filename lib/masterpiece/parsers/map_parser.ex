defmodule MapParser do
    def parse(map), do:
        Enum.map(
            map,
            fn
                {name, context} -> do_parse(name, context)
            end
        )
    defp do_parse(name, %{"scope" => scope, "options" => options}), do: ScopeParser.parse(name, scope, options)

#    defp do_parse(node_name, context), do: NodeSocketParser.parse(node_name, context)
end
