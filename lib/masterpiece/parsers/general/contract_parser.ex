defmodule ContractParser do
	def parse(contracts) when is_list(contracts), do: Enum.map(contracts, &parse(&1))

	def parse(
			%{
				"name" => name,
				"pattern" => pattern
			}
		), do: %Types.Contract{
			name: String.to_atom(name),
			pattern: String.to_atom(pattern),
			settings: %{},
		}

	def parse(
			%{
				"name" => name,
				"pattern" => pattern,
				"settings" => settings
			}
		), do: %Types.Contract{
			name: String.to_atom(name),
			pattern: String.to_atom(pattern),
			settings: settings,
		}

	def parse(options), do: raise "Contract is invalid, got: " <> Kernel.inspect(options)
end
