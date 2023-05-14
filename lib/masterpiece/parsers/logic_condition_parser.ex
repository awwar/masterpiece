defmodule LogicConditionParser do
  def parse(%{"condition" => condition, "id" => id}),
      do: %Types.LogicCondition{
        condition: ConditionParser.parse(condition),
        to_id: SocketReferenceParser.parse(id)
      }
end
