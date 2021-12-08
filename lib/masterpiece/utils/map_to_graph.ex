defmodule MapToGraph do
    def execute(map), do:
        Enum.map_reduce(map, Graph.new(), fn x, acc -> {x, do_work(x, acc)} end)
        |> then(fn {_, g} -> g end)

    defp do_work(
             %Types.LogicConnection{
                 from_id: %_{
                     id: from_id
                 },
                 default: nil,
                 condition: %Types.LogicCondition{
                     to_id: %_{
                         id: to_id
                     }
                 }
             },
             g
         ), do: Graph.add_edge(g, from_id, to_id)
    defp do_work(
             %Types.LogicConnection{
                 from_id: %_{
                     id: from_id
                 },
                 default: %_{
                     id: to_id
                 }
             },
             g
         ), do: Graph.add_edge(g, from_id, to_id)
end
