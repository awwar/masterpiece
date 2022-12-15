defmodule ContractParser do
	def parse(contracts) when is_list(contracts), do: Enum.map(contracts, &parse(&1))

	def parse(
			%{
				"name" => name,
				"pattern" => pattern
			} = setting
		), do: do_parse(name, pattern, Map.get(setting, "settings", %{}), Map.get(setting, "casts", []))

	def parse(options), do: raise "Contract is invalid, got: " <> Kernel.inspect(options)

	defp do_parse(name, pattern, settings, casts),
		 do: %Types.Contract{
			 name: name,
			 pattern: String.to_atom(pattern),
			 settings: settings,
			 casts: casts,
		 }
end
