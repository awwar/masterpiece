defmodule HttpHandlerCompiler do
	alias Types.Endpoints.Http
	alias Types.Endpoint

	def compile(contexts) do
		body = Enum.map(
			contexts,
			fn %Endpoint{
				   flow: flow,
				   options: %Http{
					   route: route,
					   method: method,
				   },
			   } ->
				quote do
					def call(unquote(method), unquote(route), conn) do
						{code, result} = unquote(flow).execute(
							%{
								query: Plug.Conn.Query.decode(conn.query_string),
								body: conn.body_params
							}
						)

						%{code: response_code, content_type: content_type, data: result} = result

						Plug.Conn.resp(conn, response_code, encode_body(content_type, result))
						|> Plug.Conn.put_resp_content_type(get_content_type(content_type))
						|> Plug.Conn.send_resp()
					rescue
						e -> Plug.Conn.resp(conn, 500, e.message)
							 |> Plug.Conn.send_resp()
					end
				end
			end
		)

		module_content = quote do
			import Plug.Conn

			unquote_splicing(body)

			def call(_, _, conn) do
				Plug.Conn.resp(conn, 404, [])
				|> Plug.Conn.send_resp()
			end

			defp encode_body("json", data), do: Jason.encode!(data)

			defp encode_body("text", data), do: "#{data}"

			defp get_content_type("json"), do: "application/json"

			defp get_content_type("text"), do: "text/html"
		end

		TestGenerates.execute("endpoint", module_content)

		Module.create(HttpHandler, module_content, Macro.Env.location(__ENV__))
	end

end