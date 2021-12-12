defmodule NodePatterns.NumberNode do
	@behaviour Behaviors.MapEntity

	alias Types.NodeConfig

	def get_config do
		%NodeConfig{
			input: %{},
			output: %{
				result: :number
			},
			option: %{
				value: :number
			}
		}
	end

	def get_content(%{value: value}) do
		quote do
			def execute(), do: {true, %{result: unquote(value)}}
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