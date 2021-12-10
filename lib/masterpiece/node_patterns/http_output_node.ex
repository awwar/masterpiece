defmodule NodePatterns.HttpOutputNode do
    @behaviour Behaviors.MapEntity
    @encodes ["json", "text"]

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

    def get_content(%{encode: encode}) do
        resolver = get_resolver(encode)

        quote do
            def execute(conn, result) do
                conn
                |> Plug.Conn.resp(200, unquote(resolver))
                |> Plug.Conn.send_resp()
                |> then(&{:default, &1})
            end
        end
    end

    def parse_options(
            %{
                "encode" => resolver
            }
        ) when resolver in @encodes do
        %{
            encode: resolver
        }
    end
    def parse_options(
            %{
                "encode" => resolver
            }
        ), do: raise "Undefined resolver '#{resolver}}'!"

    def parse_options(_), do: raise "Unexpected options!"

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
