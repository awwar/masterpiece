defmodule Contacts.String do
	@behaviour Behaviors.Contract

	def create(_) do
		quote do
			defstruct [value: ""]

			def get_sockets, do: [:value]
			def update_value(self, key, value) when is_binary(value), do: Map.put(self, key, value)
			def update_value(_, _, _), do: raise "Not string"
			def cast_from(:binary, value) when is_binary(value), do: %__MODULE__{value: value}
			def execute(string) when is_binary(string), do: string
			def execute(_), do: raise "Not string"
		end
	end
end
