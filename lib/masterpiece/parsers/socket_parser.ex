defmodule SocketParser do
	def parse(map, order) do
		parsed_map = Enum.map(
						 map,
						 fn
							 {id, context} -> {id, do_parse(id, context)}
						 end
					 )
					 |> Map.new

		Enum.map(order, &parsed_map[&1])
	end
	defp do_parse(
			 id,
			 %{
				 "type" => "scope",
				 "settings" => %{
					 "scope" => scope,
					 "options" => options
				 }
			 }
		 ), do:
			 ScopeParser.parse(id, scope, options)

	defp do_parse(
			 id,
			 %{
				 "type" => "node",
				 "settings" => %{
					 "node" => name,
					 "input" => input
				 }
			 }
		 ), do:
			 NodeSocketParser.parse(id, name, input)
end
