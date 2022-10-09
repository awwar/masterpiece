defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def create(_), do: Contacts.String.Parser
end

defmodule Contacts.String.Parser do
	@behaviour Behaviors.Contract.Parser

	def execute(string) when is_binary(string), do: string
	def execute(_), do: raise "Not string"
end
