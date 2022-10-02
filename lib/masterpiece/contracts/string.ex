defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def parse(data, _) when is_binary(data), do: data

	def parse(data, _), do: raise "Received data is not string"
end
