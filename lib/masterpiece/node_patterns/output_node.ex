defmodule NodePatterns.OutputNode do
	@behaviour Behaviors.MapEntity

	alias Types.NodeConfig

	def get_config do
		%NodeConfig{
			input: %{
				conn: :obj,
				result: :any
			},
			option: %{
				encode: :string
			}
		}
	end

	def get_content(
			%{
				output_fields: output_fields
			}
		) do
		quote do
			def execute(result) do
				{true, result}
			end
		end
	end

	def parse_options(output_fields) do
		%{
			output_fields: output_fields
		}
	end
end
