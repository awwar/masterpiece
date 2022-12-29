defmodule Contacts.Object do
	@behaviour Behaviors.Contract

	def create(setting) when is_list(setting) do
		items_ast = Enum.map(setting, &object_item_validator_ast/1)

		quote do
			def execute(object) do
				unquote({:%{}, [], items_ast})
			end
		end
	end

	defp object_item_validator_ast(%{name: name, contract: contract}) do
		contract_parser = ContractFactory.create(contract.pattern)
		parser_method = contract_parser.create(contract.settings)
		atom_name = String.to_atom(name)

		{
			atom_name,
			quote do: unquote(parser_method).execute(Map.get_lazy(object, unquote(atom_name), fn -> raise "asdasd" end))
		}
	end
end
