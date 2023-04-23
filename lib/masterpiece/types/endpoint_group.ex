defmodule Types.EndpointGroup do
	defstruct [
		name: "",
		items: [],
	]
end

defimpl Protocols.Compile, for: Types.EndpointGroup do
	alias Types.EndpointGroup
	import CompilerHelper

	def compile(%EndpointGroup{name: :http, items: endpoints}) do
		body = Enum.map(endpoints, &as_ast/1)

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

		TestGenerates.execute(module_content, "endpoint")

		Module.create(HttpHandler, module_content, Macro.Env.location(__ENV__))
	end

	def compile(%EndpointGroup{name: name}), do: raise "Undefined endpoint " <> inspect(name)
end
