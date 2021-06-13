defmodule LayoutCompiler do
    def compile(%{layout_name: layout_name, nodes: nodes, map: map}) do
        Enum.each(
            nodes,
            fn {name, context} -> NodeCompiler.compile(name, context) end
        )

        runner_content = RunnerContentCompiler.compile(map)
        conn = {:conn, [], nil}

        module_content = quote do
            def run(%{http: unquote(conn)}), do: execute(unquote(conn))

            def run(%{kafka: unquote(conn)}), do: execute(unquote(conn))

            defp execute(unquote(conn)), do: unquote({:__block__, [], runner_content})
        end

        #        IO.puts Macro.to_string(module_content)
        #        exit(0)

        Module.create(layout_name, module_content, Macro.Env.location(__ENV__))
    end
end
