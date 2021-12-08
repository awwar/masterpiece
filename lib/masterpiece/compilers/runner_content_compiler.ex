defmodule RunnerContentCompiler do
    alias Types.NodeSocket
    alias Types.Scope

    def compile(sockets, map) do
        sockets
        |> Enum.map(
               fn
                   %NodeSocket{} = node -> get_node_resolver(node)
                   %Scope{} = scope -> get_scope_resolver(scope)
               end
           )
    end

    defp get_node_resolver(%NodeSocket{name: node_name, inputs: inputs}) do
        new_args = Enum.map(
            inputs,
            fn context -> CompilerHelper.create_argument_variable(context) end
        )

        node_call = quote do: unquote(node_name).execute(unquote_splicing(new_args))

        quote do: unquote(CompilerHelper.get_node_result_variable(node_name)) = unquote(node_call)
    end

    defp get_scope_resolver(%Scope{scope: scope, options: options}) do
        scope.get_content(options)
    end
end
