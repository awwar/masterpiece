defmodule ConditionParserTest do
	use ExUnit.Case
	alias ConditionParser

	@moduletag :capture_log

	doctest ConditionParser

	test "parser works" do
		expects = %Types.Expression{
			left: %Types.Condition{
				value: 1
			},
			method: "+",
			right: %Types.Expression{
				left: %Types.Condition{
					value: 2
				},
				method: "*",
				right: %Types.Condition{
					value: 3
				}
			}
		}
		actual = ConditionParser.parse([1, "+", [2, "*", 3]])
		assert expects === actual
	end

	test "parsed condition is compilable" do
		condition = ConditionParser.parse([1, "+", [2, "*", 3]])
		iex = ConditionCompiler.compile(condition)

		{result, _} = Code.eval_quoted(iex)

		assert result === 7
	end

	test "parsed condition is compilable with dynamic vars" do
		condition = ConditionParser.parse([1, "+", [%{"node" => "var", "path" => ["a"]}, "*", 3]])
		iex = ConditionCompiler.compile(condition)

		{result, _} = Code.eval_quoted(
			iex,
			[
				var_result: %{
					a: 11
				}
			]
		)

		assert result === 34
	end

	test "parsed condition is compilable with constant vars" do
		condition = ConditionParser.parse([1, "+", [%{"variable" => "some_var", "path" => []}, "*", 3]])
		iex = ConditionCompiler.compile(condition)

		{result, _} = Code.eval_quoted(iex, [some_var: 11])

		assert result === 34
	end
end
