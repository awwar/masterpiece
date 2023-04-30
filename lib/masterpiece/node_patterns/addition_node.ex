defmodule NodePatterns.AdditionNode do
	@behaviour Behaviors.MapEntity

  # парсер должен заранее понять какие типы данных приходят ещё на шаге компиляции
	def get_content(_) do
		quote do
			def execute(%_{value: a}, %_{value: b}) when is_number(a) and is_number(b), do: {true, number_factory(a + b)}
			def execute(a, b), do: execute(NumberParser.parse(a), NumberParser.parse(b))

      defp number_factory(a), do: :float_contract_module.constructor(a)
      defp number_factory(a), do: :integer_contract_module.constructor(a)
		end
	end

	def parse_options(_) do
		%{}
	end
end
