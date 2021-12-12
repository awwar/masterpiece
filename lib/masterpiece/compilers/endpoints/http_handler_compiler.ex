defmodule HttpHandlerCompiler do

	def compile(contexts) do
		body = Enum.map(
			contexts,
			fn %{layout_name: layout_name, route: route, method: method} ->
				quote do
					def call(unquote(method), unquote(route), conn) do
						unquote(layout_name).run(%{http: conn})
					end
				end
			end
		)

		module_content = quote do
			import Plug.Conn

			unquote(body)

			def call(_, _, conn) do
				Plug.Conn.resp(conn, 404, [])
				|> Plug.Conn.send_resp()
			end
		end

		Module.create(HttpHandler, module_content, Macro.Env.location(__ENV__))
	end
end
