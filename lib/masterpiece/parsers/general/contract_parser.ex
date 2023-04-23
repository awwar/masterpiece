defmodule ContractParser do
	alias Types.Contract

	def parse(contracts) when is_list(contracts), do: contracts |> Enum.map(&parse(&1))

	def parse(%{"name" => name, "extends" => pattern} = setting),
      do: %Contract{
        name: name,
        extends: String.to_atom(pattern),
        settings: Map.get(setting, "settings", %{}),
        cast_from: Map.get(setting, "cast_from", []),
      }

	def parse(options), do: raise "Contract is invalid, got: " <> Kernel.inspect(options)
end
