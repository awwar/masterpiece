defmodule MapParser do
    def parse(map), do:
        Enum.map(
            map,
            fn
                {id, value} -> do_parse(id, value)
            end
        )
        |> List.flatten()
    defp do_parse(id, conditions) when is_list(conditions), do:
        Enum.map(conditions, &%Types.LogicConnection{from_id: %Types.SocketReference{id: id}, condition: LogicConditionParser.parse(&1)})

    defp do_parse(id, value) when is_binary(value), do:
        %Types.LogicConnection{from_id: %Types.SocketReference{id: id}, default: %Types.SocketReference{id: value}}
end
