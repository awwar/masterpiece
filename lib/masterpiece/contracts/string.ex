defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			def execute(string) when is_binary(string), do: string
			def execute(_), do: raise "Not string"
		end
	end
end
