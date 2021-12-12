defmodule RunnerContentCompiler do
    alias Types.NodeSocket
    alias Types.ScopeSocket

    def compile(sockets, map) do
        root = List.first(sockets)

        get_node_resolver(root, map, sockets)
    end

    defp get_node_resolver([], _, _) do
        nil
    end

    defp get_node_resolver(
             %NodeSocket{
                 id: id,
                 name: %Types.NodeReference{
                     name: node_name
                 },
                 inputs: inputs
             },
             map,
             sockets
         ) do
        node_state_variable = CompilerHelper.get_node_result_variable(node_name)
        next_nodes_resolver = get_next(id, map, sockets)
                              |> Enum.map(fn {f, n} -> {f, get_node_resolver(n, map, sockets)} end)

        next_nodes_resolver = if next_nodes_resolver === [],
                                 do: [{{:_, [], nil}, node_state_variable}], else: next_nodes_resolver


        new_args = Enum.map(inputs, &CompilerHelper.create_argument_variable(&1))

        node_call = quote do: unquote(node_name).execute(unquote_splicing(new_args))
        quote do
            {ctrl_code, unquote(node_state_variable)} = unquote(node_call)

            case ctrl_code do
                unquote(Enum.map(next_nodes_resolver, fn {f, n} -> {:->, [], [[f], n]} end))
            end
        end
    end

    defp get_node_resolver(%ScopeSocket{id: id, scope: scope, options: options}, map, sockets) do
        next_nodes_resolver = get_next(id, map, sockets)
                              |> Enum.map(fn {f, n} -> {f, get_node_resolver(n, map, sockets)} end)

        if next_nodes_resolver === [], do: raise "Scope can't be a leaf of a socket tree!"

        node_call = scope.get_content(options)
        quote do
            case unquote(node_call) do
                unquote(Enum.map(next_nodes_resolver, fn {f, n} -> {:->, [], [[f], n]} end))
            end
        end
    end

    defp get_next(id, map, sockets) do
        Enum.filter(map, fn %Types.LogicConnection{from_id: from_id} -> from_id === id end)
        |> Enum.map(
               fn
                   %Types.LogicConnection{
                       condition: %Types.LogicCondition{
                           to_id: to_id,
                           condition: %Types.Condition{
                               value: value
                           }
                       }
                   } -> {value, Enum.find(sockets, fn %_{id: id} -> id.id == to_id.id end)}
                   nil -> {nil, nil}
               end
           )
    end
end
