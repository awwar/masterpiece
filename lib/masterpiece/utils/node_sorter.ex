defmodule NodeSorter do
    def pull(data),
        do: pull(data, [])
            |> Enum.uniq

    def pull([], acc), do: acc

    def pull([h | b], acc), do: pull(h, acc) ++ pull(b, acc)

    def pull(n, acc) when is_atom(n), do: acc

    def pull(%Types.NodeInput{name: name}, acc), do: acc ++ [name]

    def pull(%Types.NodeSocket{inputs: inputs}, acc),
        do: acc ++ pull(inputs, acc)

    def pull(
            %Types.ScopeSocket{
                scope: scope,
                options: options
            },
            acc
        ),
        do: acc ++ scope.pull_dependencies(options)

    def sort(nodes) when is_list(nodes) do
        Enum.map(nodes, fn node -> {node, pull(node)}  end)
        |> Enum.sort(fn {%_{name: name}, _}, {_, output} -> Enum.member?(output, name) === true end)
        |> Enum.map(fn {node, _} -> node end)
    end
end
