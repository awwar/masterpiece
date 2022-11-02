defmodule ContractCompiler do
	def compile(contracts) when is_list(contracts), do: Enum.each(contracts, &compile/1)

	def compile(contract) do  end
end
