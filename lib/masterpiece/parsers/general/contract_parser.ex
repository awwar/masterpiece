defmodule ContractParser do
	alias Types.Contract

	def parse(contracts) when is_list(contracts), do:
		contracts |> Enum.map(&parse(&1))

	def parse(
			%{
				"name" => name,
				"extends" => pattern
			} = setting
		), do: do_parse(name, pattern, Map.get(setting, "settings", %{}), Map.get(setting, "cast_from", []))

	def parse(options), do: raise "Contract is invalid, got: " <> Kernel.inspect(options)

	defp do_parse(name, pattern, settings, cast_from),
		 do: %Contract{
			 name: name,
			 extends: String.to_atom(pattern),
			 settings: settings,
			 cast_from: cast_from,
		 }
end
