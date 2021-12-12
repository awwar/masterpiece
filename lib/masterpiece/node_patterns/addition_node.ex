defmodule NodePatterns.AdditionNode do
	@behaviour Behaviors.MapEntity

	alias Types.NodeConfig

	def get_config do
		%NodeConfig{
			input: %{
				a: :number,
				b: :number
			},
			output: %{
				result: :number
			}
		}
	end

	def get_content(_) do
		quote do
			def execute(a, b) when is_number(a) and is_number(b), do: {true, %{result: a + b}}
			def execute(a, b), do: execute(NumberParser.parse(a), NumberParser.parse(b))
		end
	end

	def parse_options(_) do
		%{}
	end
end
