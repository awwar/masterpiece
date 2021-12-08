defmodule ConditionParser do
    def parse(cond) when is_binary(cond) or is_boolean(cond) or is_number(cond), do:
        %Types.Condition{left: cond}

    def parse(%{"name" => _, "path" => _} = context), do: NodeInputParser.parse(context)

    def parse([left, method, right])
        when method in ["===", ">", "<", ">=", "<=", "/", "*", "+", "-", "^"], do:
            %Types.Condition{left: parse(left), method: method, right: parse(right)}
end
