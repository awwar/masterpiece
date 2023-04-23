defmodule ConfigParser do
  alias Types.Contract

  def parse(objects) when is_list(objects) do
    Enum.map(objects, &parse(&1))
    |> Enum.map_reduce(
      %Types.App{},
      fn
        %Types.Flow{} = object, config -> reduce_item(config, object, :flows)
        %Types.Contract{} = object, config -> reduce_item(config, object, :contracts)
        %Types.Endpoint{} = object, config -> reduce_item(config, object, :endpoints)
      end
    )
    |> then(fn {_, config} -> config end)
    |> then(&Map.put(&1, :endpoints, group_endpoints(&1.endpoints)))
    |> then(&Map.put(&1, :contracts, group_contracts(&1.contracts)))
  end

  def parse(%{"type" => "flow", "params" => params}), do: FlowParser.parse(params)

  def parse(%{"type" => "endpoint", "params" => params}), do: EndpointParser.parse(params)

  def parse(%{"type" => "contract", "params" => params}), do: ContractParser.parse(params)

  def parse(%{"type" => type}), do: raise("Got unexpected config object type: " <> type)

  defp reduce_item(acc, el, key), do: {el, Map.put(acc, key, [el | Map.get(acc, key, [])])}

  defp group_endpoints(endpoints) do
    Enum.map_reduce(
      endpoints,
      %{},
      fn
        el, acc when is_map_key(acc, el.name) ->
          {el,
           Map.put(acc, el.name, %Types.EndpointGroup{
             name: el.name,
             items: [el | acc[el.name].items]
           })}

        el, acc ->
          {el, Map.put(acc, el.name, %Types.EndpointGroup{name: el.name, items: [el]})}
      end
    )
    |> then(fn {_, acc} -> acc end)
    |> Enum.map(fn {_, value} -> value end)
  end

  defp group_contracts(contracts),
    do: %Types.ContractGroup{
      name: "default",
      items: [
        %Contract{name: :string, extends: :root},
        %Contract{name: :integer, extends: :root},
        %Contract{name: :bool, extends: :root},
        %Contract{name: :float, extends: :root},
        %Contract{name: :json, extends: :root},
        %Contract{name: :numeric_string, extends: :string}
        | contracts
      ]
    }
end
