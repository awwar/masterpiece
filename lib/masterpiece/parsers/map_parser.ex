defmodule MapParser do
    def parse(map), do:
        Enum.map(
            map,
            fn
                {id, value} -> do_parse(id, value)
            end
        )
    defp do_parse(id, value) when is_list(value), do:
        %Types.LogicConnection{from_id: id, condition: LogicConditionParser.parse(value)}
    defp do_parse(id, value) when is_binary(value), do:
        %Types.LogicConnection{from_id: id, default: value}
end
