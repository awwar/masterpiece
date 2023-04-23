defmodule Types.ContractGroup do
  defstruct name: "",
            items: []
end

defimpl Protocols.Compile, for: Types.ContractGroup do
  alias Types.ContractGroup
  alias Types.Contract

  import CompilerHelper

  def compile(%ContractGroup{items: contracts}) do
    Graph.new
    |> Graph.add_edges(contracts |> Enum.map(fn %Contract{name: name, extends: extends} -> {extends, name} end))
    |> Graph.to_dot
    |> then(fn {:ok, dot} -> dot end)
    |> SaveToGenerates.execute("contract_dot.dot")

    Enum.each(contracts, &as_ast/1)
  end
end
