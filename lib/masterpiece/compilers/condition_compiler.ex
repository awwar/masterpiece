defmodule ConditionCompiler do
    def compile(%Types.Condition{left: left, method: method, right: right}) do
        left = get_value(left)
        right = get_value(right)
        cond = case method do
          nil -> quote do: unquote(left) === unquote(left)
          method -> {:"#{method}", [], [left, right]}
        end

        quote do: unquote(cond)
    end

    defp get_value(%Types.NodeInput{} = value) do
        CompilerHelper.create_argument_variable(value)
    end

    defp get_value(%Types.Condition{left: value}) do
        get_value(value)
    end

    defp get_value(value), do: value
end
#