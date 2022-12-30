defmodule Contacts.NumericString do
	@behaviour Behaviors.Contract

	# @regex ~r/^(?<!\S)(?=.)(-?(?:[0-9](?:\d*|\d{0,2}(?:,\d{3})*)))?(\.\d*[1-9eE]\d*)?(?!\S)$/

	# @fast_regex ~r/^(-?[\d,]*)?(\.[\deE]{1,})?$/

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]

			defimpl Protocols.Cast do
				def cast(%_{value: ""}, "bool"), do: unquote(Contacts.Bool.module_name).factory(false)
				def cast(_, "bool"), do: unquote(Contacts.Bool.module_name).factory(true)

				def cast(%_{value: value}, "float"), do: unquote(Contacts.Float.module_name).factory(value <> "")

				def cast(%_{value: value}, "integer"), do: unquote(Contacts.Integer.module_name).factory(value <> "")

				def cast(%_{value: value}, "string"), do: unquote(Contacts.String.module_name).factory(value)
			end

			def factory(value) when is_number(value), do: %:numeric_string_contract_module{value: Kernel.inspect value}

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
	end

	def module_name, do: :numeric_string_contract_module
end
