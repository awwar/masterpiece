defmodule NamedContractParser do
	def parse(contracts) when is_list(contracts), do: Enum.map(contracts, &parse(&1))

	def parse(
			%{
				"name" => name,
				"contract" => contract
			}
		), do: %Types.NamedContract{
			name: String.to_atom(name),
			contract: String.to_atom(contract),
		}

	def parse(options), do: raise "Named Contract is invalid, got: " <> Kernel.inspect(options)
end
