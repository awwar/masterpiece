defmodule Contacts.Bool do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
		end
	end

	def module_name, do: :bool_contract_module

	def factory(true), do: %:bool_contract_module{value: true}

	def factory(false), do: %:bool_contract_module{value: false}
end

defimpl Protocols.Cast, for: Contacts.NumericString.module_name() do
	def cast(%_{value: ""}, "bool"), do: Contacts.Bool.factory(false)
	def cast(_, "bool"), do: Contacts.Bool.factory(true)
end

defimpl Protocols.Cast, for: Contacts.String.module_name() do
	def cast(%_{value: ""}, "bool"), do: Contacts.Bool.factory(false)
	def cast(_, "bool"), do: Contacts.Bool.factory(true)
end

defimpl Protocols.Cast, for: Contacts.Float.module_name() do
	def cast(%_{value: 0.0}, "bool"), do: Contacts.Bool.factory(false)
	def cast(_, "bool"), do: Contacts.Bool.factory(true)
end

defimpl Protocols.Cast, for: Contacts.Integer.module_name() do
	def cast(%_{value: 0}, "bool"), do: Contacts.Bool.factory(false)
	def cast(_, "bool"), do: Contacts.Bool.factory(true)
end
