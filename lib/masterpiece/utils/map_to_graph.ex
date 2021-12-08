defmodule MapToGraph do
    def execute(map) do
        g = Graph.new()
        Enum.map_reduce(map, g, fn x, acc -> {x, do_work(x, acc)} end)
        |> then(fn {_, g} -> g end)


    end

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
