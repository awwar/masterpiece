defmodule ContractParser do
	alias Types.Contract

	def parse(contracts) when is_list(contracts), do: contracts |> Enum.map(&parse(&1))

	def parse(%{"name" => name, "extends" => pattern} = setting),
      do: %Contract{
        name: String.to_atom(name),
        extends: String.to_atom(pattern),
        settings: Map.get(setting, "settings", %{}),
        cast_to: Map.get(setting, "cast_to", []) |> Enum.map(&String.to_atom/1),
      }

	def parse(options), do: raise "Contract is invalid, got: " <> Kernel.inspect(options)
end
