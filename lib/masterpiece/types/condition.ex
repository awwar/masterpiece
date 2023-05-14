defmodule Types.Condition do
  defstruct [:value]
end

defimpl Protocols.Compile, for: Types.Condition do
  def compile(%Types.Condition{value: value}, _) do
    value
  end
end
