defmodule Contacts.NumericString do
	@behaviour Behaviors.Contract

	def parse(data, _) when is_numeric(data), do: data

	def parse(data, _), do: raise "Received data is not numeric"
end
