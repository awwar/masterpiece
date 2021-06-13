defmodule NodePatterns.HttpOutputNode do
    @behaviour Behaviors.MapEntity

    alias Types.NodeConfig

    def get_config do
        %NodeConfig{
            input: %{
                conn: :obj,
                result: :any
            },
            option: %{
                encode: :string
            }
        }
    end

    def get_content(%{encode: resolver}) do
        quote do
            def execute(conn, result) do
                conn
                |> Plug.Conn.resp(200, unquote(resolver))
                |> Plug.Conn.send_resp()
            end
        end
    end

    def parse_options(
            %{
                "encode" => encode
            }
        ) do
        %{
            encode: get_resolver(encode)
        }
    end

    defp get_resolver("json") do
        quote do: Jason.encode!(result)
    end

    defp get_resolver("text") do
        quote do: "#{result}"
    end

    defp get_resolver(resolver) do
        raise "Undefined resolver '#{resolver}}'!"
    end
end
