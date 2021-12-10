defmodule CompilerHelper do
    def get_node_result_variable(%Types.NodeReference{name: node_name}) do
        node_name
        |> then(&String.to_atom("#{&1}_result"))
        |> Macro.var(nil)
    end

    def get_node_result_variable(node_name) when is_atom(node_name) do
        node_name
        |> then(&String.to_atom("#{&1}_result"))
        |> Macro.var(nil)
    end

    def create_argument_variable(%Types.NodeInput{type: :node, name: node_reference, path: out}), do:
        quote do: ExtendMap.get_in!(
            unquote(get_node_result_variable(node_reference)),
            unquote(out)
        )

    def create_argument_variable(%Types.NodeInput{type: :object, name: object_name}) when is_atom(object_name),
        do: Macro.var(object_name, nil)
end
