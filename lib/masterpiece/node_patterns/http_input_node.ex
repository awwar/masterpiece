defmodule NodePatterns.HttpInputNode do
    @behaviour Behaviors.MapEntity

    alias Types.NodeConfig

    def get_config do
        %NodeConfig{
            input: %{
                conn: :obj
            },
            output: %{
                result: :obj
            }
        }
    end

    def get_content(_) do
        quote do
            def execute(conn) do
                %{
                    query: Plug.Conn.Query.decode(conn.query_string),
                    body: conn.body_params
                }
            end
        end
    end

    def parse_options(_) do
        %{}
    end
end
