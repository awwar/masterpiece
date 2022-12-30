defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]

			defimpl Protocols.Cast do
				def cast(%_{value: ""}, "bool"), do: unquote(Contacts.Bool.module_name).factory(false)
				def cast(_, "bool"), do: unquote(Contacts.Bool.module_name).factory(true)

				def cast(%_{value: value}, "float"), do: unquote(Contacts.Float.module_name).factory(value <> "")

				def cast(%_{value: value}, "integer"), do: unquote(Contacts.Integer.module_name).factory(value <> "")

				def cast(_, "numeric_string"), do: unquote(Contacts.NumericString.module_name).factory(0)
			end

			def factory(value), do: %:string_contract_module{value: Kernel.inspect value}
		end
	end

	def module_name, do: :string_contract_module
end
