defmodule Contacts.Bool do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]

			defimpl Protocols.Cast do
				def cast(%_{value: true}, "float"), do: unquote(Contacts.Float.module_name).factory(1.0)
				def cast(%_{value: false}, "float"), do: unquote(Contacts.Float.module_name).factory(0.0)

				def cast(%_{value: true}, "integer"), do: unquote(Contacts.Integer.module_name).factory(1.0)
				def cast(%_{value: false}, "integer"), do: unquote(Contacts.Integer.module_name).factory(0.0)

				def cast(%_{value: true}, "numeric_string"), do: unquote(Contacts.NumericString.module_name).factory(1)
				def cast(%_{value: false}, "numeric_string"), do: unquote(Contacts.NumericString.module_name).factory(0)

				def cast(_, "string"), do: unquote(Contacts.String.module_name).factory("")
			end

			def factory(true), do: quote(do: %:bool_contract_module{value: true})

			def factory(false), do: quote(do: %:bool_contract_module{value: false})
		end
	end

	def module_name, do: :bool_contract_module
end
