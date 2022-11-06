defmodule ScopePatterns.IfScope do
	import CompilerHelper

	def get_content(
			%{
				condition: condition,
			}
		) do
		as_ast(condition)
	end

	def parse_options(%{"condition" => cond}) do
		%{
			condition: ConditionParser.parse(cond)
		}
	end
end
