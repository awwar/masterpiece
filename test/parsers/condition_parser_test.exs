defmodule ConditionParserTest do
  use ExUnit.Case
  alias ConditionParser
  import CompilerHelper

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
    ConditionParser.parse([1, "+", [2, "*", 3]])
    |> as_ast
    |> Code.eval_quoted()
    |> then(fn {result, _} -> result end)
    |> then(&(&1 === 7))
    |> assert
  end

  test "parsed condition is compilable with dynamic vars" do
    ConditionParser.parse([1, "+", [%{"node" => "var", "path" => ["a"]}, "*", 3]])
    |> as_ast
    |> Code.eval_quoted(
      var: %{
        a: 11
      }
    )
    |> then(fn {result, _} -> result end)
    |> then(&(&1 === 34))
    |> assert
  end

  test "parsed condition is compilable with constant vars" do
    ConditionParser.parse([1, "+", [%{"variable" => "some_var", "path" => []}, "*", 3]])
    |> as_ast
    |> Code.eval_quoted(some_var: 11)
    |> then(fn {result, _} -> result end)
    |> then(&(&1 === 34))
    |> assert
  end
end
