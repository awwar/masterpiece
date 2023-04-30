defmodule NodePatterns.NumberNode do
	@behaviour Behaviors.MapEntity

	def get_content(%{value: value}) do
    result = value |> :integer_contract_module.constructor |> Macro.escape

		quote do
			def execute, do: {true, unquote(result)}
		end
	end

	def parse_options(
			%{
				"value" => value
			}
		) do
		%{
			value: NumberParser.parse(value)
		}
	end
end
