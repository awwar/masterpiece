defmodule ConditionParser do
    def parse(cond) when is_binary(cond) or is_boolean(cond) or is_number(cond), do: cond

    def parse(%{"name" => _, "path" => _} = context), do:
        CompilerHelper.create_argument_variable(NodeSocketParser.parse_input(context))

    def parse(%{"name" => name}), do:
        CompilerHelper.create_argument_variable(NodeSocketParser.parse_input(name))

    def parse([left, method, right])
        when method in ["===", ">", "<", ">=", "<=", "/", "*", "+", "-", "^"], do:
            {String.to_atom(method), [], [parse(left), parse(right)]}
end
