defmodule Contacts.Integer do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
		end
	end

	def module_name, do: :integer_contract_module

	def factory(value), do: %:integer_contract_module{value: true}
end

defimpl Protocols.Cast, for: Contacts.Bool.module_name() do
	def cast(%_{value: true}, "integer"), do: Contacts.Integer.factory(1.0)
	def cast(%_{value: false}, "integer"), do: Contacts.Integer.factory(0.0)
end

defimpl Protocols.Cast, for: Contacts.Float.module_name() do
	def cast(%_{value: value}, "integer"), do: trunc(value) |> Contacts.Integer.factory
end

defimpl Protocols.Cast, for: Contacts.NumericString.module_name() do
	def cast(%_{value: value}, "integer"), do: Contacts.Integer.factory(value <> "")
end

defimpl Protocols.Cast, for: Contacts.String.module_name() do
	def cast(%_{value: value}, "integer"), do: Contacts.Integer.factory(value <> "")
end
