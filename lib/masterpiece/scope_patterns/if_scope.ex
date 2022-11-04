defmodule ScopePatterns.IfScope do
	def get_content(
			%{
				condition: condition,
			}
		) do
		Protocols.Compile.compile(condition)
	end

	def parse_options(%{"condition" => cond}) do
		%{
			condition: ConditionParser.parse(cond)
		}
	end
end
