defmodule Contacts.NumericString do
	@behaviour Behaviors.Contract

	# @regex ~r/^(?<!\S)(?=.)(-?(?:[0-9](?:\d*|\d{0,2}(?:,\d{3})*)))?(\.\d*[1-9eE]\d*)?(?!\S)$/

	# @fast_regex ~r/^(-?[\d,]*)?(\.[\deE]{1,})?$/

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
		end
	end

	def module_name, do: :numeric_string_contract_module

	def factory(value) when is_number(value), do: %:numeric_string_contract_module{value: Kernel.inspect(value)}
	def factory(value) when is_binary(value) do
		try do
			:erlang.binary_to_integer(value)
		rescue
			_ -> :erlang.binary_to_float(value)
		end
		|> factory
	rescue
		_ -> reraise RuntimeError, "Is not a number", __STACKTRACE__
	end
	def factory(_), do: raise "Is not a number"
end

defimpl Protocols.Cast, for: Contacts.Bool.module_name() do
	def cast(%_{value: true}, "numeric_string"), do: Contacts.NumericString.factory(1)
	def cast(%_{value: false}, "numeric_string"), do: Contacts.NumericString.factory(0)
end

defimpl Protocols.Cast, for: Contacts.Float.module_name() do
	def cast(%_{value: value}, "numeric_string"), do: Contacts.NumericString.factory(value)
end

defimpl Protocols.Cast, for: Contacts.Integer.module_name() do
	def cast(%_{value: value}, "numeric_string"), do: Contacts.NumericString.factory(value)
end

defimpl Protocols.Cast, for: Contacts.String.module_name() do
	def cast(_, "numeric_string"), do: Contacts.NumericString.factory(0)
end
