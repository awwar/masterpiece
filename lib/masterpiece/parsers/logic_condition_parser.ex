defmodule LogicConditionParser do
#    def parse(conditions), do: Enum.map(conditions, &do_parse(&1))

    def parse(%{"condition" => condition, "id" => id}), do:
        %Types.LogicCondition{condition: ConditionParser.parse(condition), to_id: %Types.SocketReference{id: id}}
end
