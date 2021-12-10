defmodule RunnerContentCompiler do
    alias Types.NodeSocket
    alias Types.ScopeSocket

    def compile(sockets, map) do
        root = List.first(sockets)

        get_node_resolver(root, map, sockets)
    end

    defp get_node_resolver(nil, map, sockets) do
        nil
    end

    defp get_node_resolver(%NodeSocket{id: id, name: %Types.NodeReference{name: node_name}, inputs: inputs}, map, sockets) do
        new_args = Enum.map(
            inputs,
            fn context -> CompilerHelper.create_argument_variable(context) end
        )

        node_call = quote do: unquote(node_name).execute(unquote_splicing(new_args))
        node_state_variable = CompilerHelper.get_node_result_variable(node_name)
        {next_node, rest_map} = get_next(id, map, sockets)
        next_node_resolver = get_node_resolver(next_node, rest_map, sockets)

        next_node_resolver = if next_node_resolver === nil, do: node_state_variable, else: next_node_resolver

        quote do
            {ctrl_code, unquote(node_state_variable)} = unquote(node_call)

            case ctrl_code do
                :exit -> IO.puts("Program ends")
                _ -> unquote(next_node_resolver)
            end
        end
    end

    defp get_node_resolver(%ScopeSocket{id: id, scope: scope, options: options}, map, sockets) do
        node_call = scope.get_content(options)
        {next_node, rest_map} = get_next(id, map, sockets)
        next_node_resolver = get_node_resolver(next_node, rest_map, sockets)

        if next_node_resolver === nil, do: raise "Scope can't be a leaf of a socket tree!"

        quote do
            {ctrl_code, _} = unquote(node_call)

            case ctrl_code do
                :exit -> IO.puts("Program ends")
                _ -> unquote(next_node_resolver)
            end
        end
    end

    defp get_next(id, map, sockets) do
        connection = Enum.find(map, fn %Types.LogicConnection{from_id: from_id} -> from_id === id end)
        rest = List.delete(map, connection)

        to_id = case connection do
            %Types.LogicConnection{default: nil, condition: %_{to_id: to_id}} -> to_id
            %Types.LogicConnection{default: to_id} -> to_id
            nil -> nil
        end

        {Enum.find(sockets, fn %_{id: id} -> id === to_id end), rest}
    end
end
