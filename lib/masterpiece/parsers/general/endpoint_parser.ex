defmodule EndpointParser do
	def parse(endpoints), do: Enum.map(endpoints, fn {name, context} -> do_parse(name, context) end)

	defp do_parse("http", %{"route" => route, "method" => method}),
		 do: %Type.Endpoints.Http{
			 name: :http,
			 route: route,
			 method: method
		 }

	defp do_parse("http", options), do: raise "Endpoint 'http' not valid, got: " <> Kernel.inspect(options)

	defp do_parse("kafka", %{"topic" => topic}),
		 do: %Type.Endpoints.Http{
			 name: :http,
			 topic: topic,
		 }

	defp do_parse("kafka", options), do: raise "Endpoint 'kafka' not valid, got: " <> Kernel.inspect(options)

	defp do_parse(endpoint, _), do: raise "Endpoint '#{endpoint}' not found!"
end
