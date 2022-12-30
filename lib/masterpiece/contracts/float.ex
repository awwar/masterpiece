defmodule Contacts.Float do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]

			defimpl Protocols.Cast do
				def cast(%_{value: 0.0}, "bool"), do: unquote(Contacts.Bool.module_name).factory(false)
				def cast(_, "bool"), do: unquote(Contacts.Bool.module_name).factory(true)

				def cast(%_{value: value}, "integer"), do: trunc(value) |> unquote(Contacts.Integer.module_name).factory

				def cast(%_{value: value}, "numeric_string"), do: unquote(Contacts.NumericString.module_name).factory(value)

				def cast(%_{value: value}, "string"), do: unquote(Contacts.String.module_name).factory(value)
			end

			def factory(value), do: %:float_contract_module{value: value}
		end
	end

	def module_name, do: :float_contract_module
end
