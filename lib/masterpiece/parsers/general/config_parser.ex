defmodule ConfigParser do
	def parse(objects) when is_list(objects), do:
		Enum.map(objects, &parse(&1))
		|> Enum.map_reduce(
			   %Types.Config{},
			   fn
				   %Types.Flow{} = object, config -> reduce_item(config, object, :flows)
				   %Types.Contract{} = object, config -> reduce_item(config, object, :contracts)
				   %Types.Endpoint{} = object, config -> reduce_item(config, object, :endpoints)
			   end
		   )
		|> then(fn {_, config} -> config end)

	def parse(%{"type" => "flow", "params" => params}), do: FlowParser.parse(params)

	def parse(%{"type" => "endpoint", "params" => params}), do: EndpointParser.parse(params)

	def parse(%{"type" => "contract", "params" => params}), do: ContractParser.parse(params)

	def parse(%{"type" => type}), do: raise "Got unexpected config object type: " <> type

	defp reduce_item(acc, el, key), do: {el, Map.put(acc, key, [el | acc[key]])}
end

