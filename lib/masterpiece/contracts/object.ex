defmodule Contacts.Object do
	@behaviour Behaviors.Contract

	# парсер должен возвращать функцию которая спарсит конкретный объект
	def parse(data, _) when is_map(data) or is_struct(data) do
		map = {}


	end

	def parse(data, %{name: name}), do: raise "Received data is not object #{name}"
end
