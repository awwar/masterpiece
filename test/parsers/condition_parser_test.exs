defmodule ConditionParserTest do
    use ExUnit.Case
    alias ConditionParser

    @moduletag :capture_log

    doctest ConditionParser

    test "parser works" do
        assert ConditionParser.parse([1, "+", [2, "*", 3]]) === {:+, [], [1, {:*, [], [2, 3]}]}
    end

    test "parsed condition is compilable" do
        iex = ConditionParser.parse([1, "+", [2, "*", 3]])

        {result, _} = Code.eval_quoted(iex)

        assert result === 7
    end

    test "parsed condition is compilable with dynamic vars" do
        iex = ConditionParser.parse([1, "+", [%{"name" => "var", "path" => ["a"]}, "*", 3]])

        {result, _} = Code.eval_quoted(iex, [var_result: %{a: 11}])

        assert result === 34
    end

    test "parsed condition is compilable with constant vars" do
        iex = ConditionParser.parse([1, "+", [%{"name" => "some_var"}, "*", 3]])

        {result, _} = Code.eval_quoted(iex, [some_var: 11])

        assert result === 34
    end
end
