defmodule Types.Endpoint do
  defstruct [
    name: "",
    flow: "",
    options: %{},
  ]
end

defimpl Protocols.Compile, for: Types.Endpoint do
  alias Types.Endpoint
  alias Types.Endpoint.Http

  def compile(
        %Endpoint{
          flow: flow,
          options: %Http{
            route: route,
            method: method,
          }
        },
        _
      ) do
    quote do
      def call(unquote(method), unquote(route), conn) do
        {code, result} = :http_connect_cm.constructor(conn)
        |> :http_connect_cm.cast_to(:map_cm)
        |> unquote(flow).execute

        %{code: response_code, content_type: content_type, data: result} = result

        Plug.Conn.resp(conn, response_code, encode_body(content_type, result))
        |> Plug.Conn.put_resp_content_type(get_content_type(content_type))
        |> Plug.Conn.send_resp()
      rescue
        e -> Plug.Conn.resp(conn, 500, IO.inspect(e).message)
             |> Plug.Conn.send_resp()
      end
    end
  end
end
