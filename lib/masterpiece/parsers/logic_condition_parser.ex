defmodule LogicConditionParser do
    def parse(conditions), do: Enum.map(conditions, &do_parse(&1))

    defp do_parse(%{"condition" => condition, "id" => id}), do:
        %Types.LogicCondition{condition: ConditionParser.parse(condition), to_id: id}
end
