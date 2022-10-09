defmodule Contacts.Object do
	@behaviour Behaviors.Contract

	# парсер должен возвращать функцию которая спарсит конкретный объект
	def create(setting) do
		callback = fn  ->  end

		callback
	end
end
