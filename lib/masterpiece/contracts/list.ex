defmodule Contacts.List do
	@behaviour Behaviors.Contract

	def create(setting) do
		module_name = :crypto.strong_rand_bytes(12)
					  |> Base.encode64(padding: false)
					  |> String.to_atom
		{:module, module, _, _} = Module.create(module_name, execute_body_ast(setting), Macro.Env.location(__ENV__))

		module
	end

	defp execute_body_ast(settings) do
		validator_module = list_item_validator(settings)

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
