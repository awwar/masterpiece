defmodule Mix.Tasks.Mtp.Compile do
    use Mix.Task

    def run(params) do
        with {[config: path], _, _} <- OptionParser.parse(
            params,
            switches: [
                config: :string
            ]
        ) do
            {:ok, content} = Path.join(File.cwd!(), path)
                             |> File.read()

            "." <> extension = Path.extname(path)

            parsed_layout = content
            |> RawConfigParser.parse(extension)
            |> LayoutParser.parse


            MapToGraph.execute(List.first(parsed_layout).map)
            |> Graph.Serializers.DOT.serialize()
            |> then(fn {:ok, data} -> data end)
            |> IO.puts()
        else
            _ -> IO.warn("Path to config is empty! Use: mix mtp.compile --config <path to config>")
        end
    end
end
