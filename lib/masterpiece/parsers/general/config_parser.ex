defmodule ConfigParser do
	def parse(objects) when is_list(objects), do: Enum.map(objects, &parse(&1))

	def parse(%{"type" => "flow", "params" => params}), do: FlowParser.parse(params)

	def parse(%{"type" => "endpoint", "params" => params}), do: EndpointParser.parse(params)

	def parse(%{"type" => type}), do: raise "Got unexpected config object type: " <> type
end
