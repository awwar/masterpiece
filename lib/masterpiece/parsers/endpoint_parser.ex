defmodule EndpointParser do
	def parse(endpoints), do: Enum.map(endpoints, fn {name, context} -> do_parse(name, context) end)

	defp do_parse("http", %{"route" => route, "method" => method}) do
		{
			:http,
			%{
				route: route,
				method: method
			}
		}
	end
	defp do_parse("http", options), do: raise "Endpoint 'http' not valid, got: " <> Kernel.inspect(options)

	defp do_parse("kafka", %{"topic" => topic}) do
		{
			:kafka,
			%{
				topic: topic
			}
		}
	end
	defp do_parse("kafka", options), do: raise "Endpoint 'kafka' not valid, got: " <> Kernel.inspect(options)

	defp do_parse(endpoint, _), do: raise "Endpoint '#{endpoint}' not found!"
end
