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
					   encode: encode
				   }
			   } ->
				quote do
					def call(unquote(method), unquote(route), conn) do
						{code, result} = unquote(flow).execute(
							%{
								query: Plug.Conn.Query.decode(conn.query_string),
								body: conn.body_params
							}
						)

						Plug.Conn.resp(conn, (if code === true, do: 200, else: 403), unquote(get_resolver(encode)))
						|> Plug.Conn.put_resp_content_type(unquote(get_content_type(encode)))
						|> Plug.Conn.send_resp()
					rescue
						_ -> Plug.Conn.resp(conn, 500, nil) |> Plug.Conn.send_resp()
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
		end

		Module.create(HttpHandler, module_content, Macro.Env.location(__ENV__))
	end

	defp get_resolver(:json), do: quote do: Jason.encode!(result)

	defp get_resolver(:text), do: quote do: "#{result}"

	defp get_resolver(resolver), do: raise "Undefined resolver '#{resolver}}'!"

	defp get_content_type(:json), do: "application/json"

	defp get_content_type(:text), do: "text/html"

	defp get_content_type(resolver), do: raise "Undefined resolver '#{resolver}}'!"
end