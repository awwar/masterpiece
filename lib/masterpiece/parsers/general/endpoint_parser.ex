defmodule EndpointParser do
  def parse(endpoints) when is_list(endpoints), do: Enum.map(endpoints, &parse(&1))

  def parse(%{
        "type" => "http",
        "route" => route,
        "method" => method,
        "flow" => flow
      }),
      do: %Types.Endpoint{
        name: :http,
        flow: String.to_atom(flow),
        options: %Types.Endpoint.Http{
          route: route,
          method: method
        }
      }

  def parse(%{"type" => "kafka", "topic" => topic, "flow" => flow}),
    do: %Types.Endpoint{
      name: :kafka,
      flow: String.to_atom(flow),
      options: %Types.Endpoint.Kafka{
        topic: topic
      }
    }

  def parse(options), do: raise("Endpoint is invalid, got: " <> Kernel.inspect(options))
end
