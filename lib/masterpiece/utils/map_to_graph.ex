defmodule MapToGraph do
	def execute(map), do:
		Enum.map_reduce(map, Graph.new(), fn x, acc -> {x, do_work(x, acc)} end)
		|> then(fn {_, g} -> g end)

	defp do_work(
			 %Types.LogicConnection{
				 from_id: %Types.SocketReference{
					 id: from_id
				 },
				 condition: %Types.LogicCondition{
					 to_id: %Types.SocketReference{
						 id: to_id
					 }
				 }
			 },
			 g
		 ), do: Graph.add_edge(g, from_id, to_id)
end
