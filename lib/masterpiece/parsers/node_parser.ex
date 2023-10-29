defmodule NodeParser do
  def parse(nodes), do: Enum.map(nodes, fn {name, context} -> do_parse(name, context) end)

  defp do_parse(
         name,
         %{
           "pattern" => node_pattern_name,
           "option" => options
         }
       )
       when is_map(options) do
    node_pattern = NodePatternFactory.create(node_pattern_name)

    %Types.Node{
      name: CompilerHelper.to_atom(name),
      pattern: node_pattern,
      options: node_pattern.parse_options(options)
    }
  end

  defp do_parse(name, context),
    do: raise("Unexpected node`s #{name} context, got: " <> Kernel.inspect(context))
end
