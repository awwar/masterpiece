defmodule Contacts.Custom do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			def execute(_), do: raise "Not string"
		end
	end
end
