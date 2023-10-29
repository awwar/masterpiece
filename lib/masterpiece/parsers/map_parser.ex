defmodule MapParser do
  alias Types.LogicConnection
  alias Types.SocketReference

  def parse(map),
    do:
      Enum.map(
        map,
        fn
          {id, value} -> do_parse(id, value)
        end
      )
      |> List.flatten()

  defp do_parse(id, conditions) when is_list(conditions),
    do:
      Enum.map(
        conditions,
        &%LogicConnection{
          from_id: SocketReference.from_binary(id),
          condition: LogicConditionParser.parse(&1)
        }
      )
end
