defmodule HttpHandlerCompiler do
	alias Types.Endpoints.Http
	alias Types.Endpoint

	def compile(contexts) do
		body = Enum.map(
			contexts,
			fn %Endpoint{flow: flow, options: %Http{route: route, method: method}} ->
				quote do
					def call(unquote(method), unquote(route), conn) do
						result = unquote(flow).execute(
							%{
								query: Plug.Conn.Query.decode(conn.query_string),
								body: conn.body_params
							}
						)

						Plug.Conn.resp(conn, 200, Jason.encode!(result))
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
		end

		Module.create(HttpHandler, module_content, Macro.Env.location(__ENV__))
	end
end