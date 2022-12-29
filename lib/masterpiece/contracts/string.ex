defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
		end
	end

	def module_name, do: :string_contract_module

	def factory(value), do: %:string_contract_module{value: Kernel.inspect value}
end

defimpl Protocols.Cast, for: Contacts.Bool.module_name() do
	def cast(_, "string"), do: Contacts.String.factory("")
end

defimpl Protocols.Cast, for: Contacts.Float.module_name() do
	def cast(%_{value: value}, "string"), do: Contacts.String.factory(value)
end

defimpl Protocols.Cast, for: Contacts.Integer.module_name() do
	def cast(%_{value: value}, "string"), do: Contacts.String.factory(value)
end

defimpl Protocols.Cast, for: Contacts.NumericString.module_name() do
	def cast(%_{value: value}, "string"), do: Contacts.String.factory(value)
end
