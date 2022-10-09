defmodule Contacts.NumericString do
	@behaviour Behaviors.Contract

	# @regex ~r/^(?<!\S)(?=.)(-?(?:[0-9](?:\d*|\d{0,2}(?:,\d{3})*)))?(\.\d*[1-9eE]\d*)?(?!\S)$/

	# @fast_regex ~r/^(-?[\d,]*)?(\.[\deE]{1,})?$/

	def create(_), do: Contacts.NumericString.Parser
end

defmodule Contacts.NumericString.Parser do
	@behaviour Behaviors.Contract.Parser

	def execute(value) when is_number(value), do: value
	def execute(value) when is_binary(value) do
		try do
			:erlang.binary_to_integer(value)
		rescue
			_ -> :erlang.binary_to_float(value)
		end
	rescue
		_ -> raise "Is not a number"
	end
	def execute(_), do: raise "Is not a number"
end
