defmodule AppCompiler do
    def compile(layouts) do
        layouts
        |> compile_layouts
        |> get_endpoints
        |> compile_endpoints
        |> get_endpoints_apps
        |> Macro.escape
        |> compile_application
    end

    defp get_endpoints(layouts) do
        Enum.map_reduce(
            layouts,
            %{},
            fn %{layout_name: layout_name, endpoints: endpoints} = x, acc ->
                {x, update_acc(acc, endpoints, layout_name)}
            end
        )
        |> then(fn {_, all_endpoints} -> all_endpoints end)
    end

    defp update_acc(acc, [], _) do
        acc
    end

    defp update_acc(acc, [{endpoint_name, metadata} | rest], layout_name) do
        value = Map.get(acc, endpoint_name, [])
        value = value ++ [Map.put(metadata, :layout_name, layout_name)]

        Map.put(acc, endpoint_name, value)
        |> update_acc(rest, layout_name)
    end

    defp compile_layouts(layouts) do
        Enum.each(layouts, &LayoutCompiler.compile(&1))
        layouts
    end

    defp compile_endpoints(all_endpoints) do
        Enum.each(
            all_endpoints,
            fn {name, context} -> EndpointsCompilerFactory.create(name, context) end
        )
        all_endpoints
    end

    defp get_endpoints_apps(all_endpoints) do
        Enum.map(
            all_endpoints,
            fn {endpoint_name, _} -> EndpointsApplicationsFactory.create(endpoint_name) end
        )
    end

    defp compile_application(endpoint_applications) do
        quote do
            use Application

            import Supervisor.Spec, warn: false

            def start(_type, _args) do
                children = unquote(endpoint_applications)

                Supervisor.start_link children, [strategy: :one_for_one, name: Proxy.Supervisor]
            end
        end
        |> then(&Module.create(Masterpiece.Application, &1, Macro.Env.location(__ENV__)))
    end
end
