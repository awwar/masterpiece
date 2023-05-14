defmodule SocketParser do
  def parse(map), do: Enum.map(map, fn {id, context} -> do_parse(id, context) end)

  defp do_parse(
         id,
         %{
           "type" => "scope",
           "settings" => %{
             "scope" => scope,
             "options" => options
           }
         }
       ), do: ScopeParser.parse(id, scope, options)

  defp do_parse(
         id,
         %{
           "type" => "node",
           "settings" => %{
             "node" => name,
             "input" => input
           }
         }
       ), do: NodeSocketParser.parse(id, name, input)
end
