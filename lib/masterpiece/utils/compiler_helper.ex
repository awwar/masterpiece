defmodule CompilerHelper do
    def get_node_result_variable(node_name) do
        node_name
        |> then(&String.to_atom("#{&1}_result"))
        |> Macro.var(nil)
    end

    def create_argument_variable(%Types.NodeInput{name: n_name, path: out}), do:
        quote do: ExtendMap.get_in!(
            unquote(get_node_result_variable(n_name)),
            unquote(out)
        )

    def create_argument_variable(o_name) when is_atom(o_name), do: Macro.var(o_name, nil)
end
