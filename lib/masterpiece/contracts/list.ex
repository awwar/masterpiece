defmodule Contacts.List do
	@behaviour Behaviors.Contract

	def create(setting) do
		validator_module = list_item_validator(setting)

		quote do
			def execute(data) when is_list(data), do: Enum.map(data, &unquote(validator_module).execute/1)
			def execute(_), do: raise "This is not a list"
		end
	end

	defp list_item_validator(contract) do
		contract_parser = ContractFactory.create(contract.pattern)

		contract_parser.create(contract.settings)
	end
end
