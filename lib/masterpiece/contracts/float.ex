defmodule Contacts.Float do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
		end
	end

	def module_name, do: :float_contract_module

	def factory(value), do: %:float_contract_module{value: true}
end

defimpl Protocols.Cast, for: Contacts.Bool.module_name() do
	def cast(%_{value: true}, "float"), do: Contacts.Float.factory(1.0)
	def cast(%_{value: false}, "float"), do: Contacts.Float.factory(0.0)
end

defimpl Protocols.Cast, for: Contacts.Integer.module_name() do
	def cast(%_{value: value}, "float"), do: Contacts.Float.factory(value + 0.0)
end

defimpl Protocols.Cast, for: Contacts.NumericString.module_name() do
	def cast(%_{value: value}, "float"), do: Contacts.Float.factory(value <> "")
end

defimpl Protocols.Cast, for: Contacts.String.module_name() do
	def cast(%_{value: value}, "float"), do: Contacts.Float.factory(value <> "")
end
