defmodule Types.ContractGroup do
  defstruct name: "",
            items: []
end

defimpl Protocols.Compile, for: Types.ContractGroup do
  alias Types.ContractGroup
  alias Types.Contract

  import CompilerHelper

  def compile(%ContractGroup{items: contracts}, _) do
    g =
      Graph.new()
      |> Graph.add_edges(
        contracts
        |> Enum.map(fn %Contract{name: name, extends: extends} -> {extends, name} end)
      )

    g
    |> Graph.to_dot()
    |> then(fn {:ok, dot} -> dot end)
    |> SaveToGenerates.execute("contract_dot.dot")

    Enum.each(
      contracts,
      fn
        contact ->
          as_ast(
            contact,
            %{
              parent_casts: contract_parents_casts(contact, g, contracts),
              contracts: contracts
            }
          )
      end
    )
  end

  defp contract_parents_casts(%Contract{name: name}, contracts_graph, contracts),
    do:
      contracts_graph
      |> Graph.get_shortest_path(:root_cm, name)
      |> Enum.reverse()
      |> tl()
      |> Enum.reverse()
      |> Enum.map_reduce(
        %{},
        fn i, cast_to_parent_relation ->
          {i, inheritance_map(cast_to_parent_relation, contracts, i)}
        end
      )
      |> then(fn {_, parent_casts} -> parent_casts end)

  defp inheritance_map(cast_to_parent_relation, contracts, name) do
    parent_contract = Enum.find(contracts, %{name: :root_cm, cast_to: []}, &(&1.name == name))

    parent_contract.cast_to
    |> Enum.map_reduce(
      cast_to_parent_relation,
      fn i, acc -> {i, Map.put(acc, i, parent_contract.name)} end
    )
    |> then(fn {_, cast_to_parent_relation} -> cast_to_parent_relation end)
  end
end
