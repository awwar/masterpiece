defmodule HttpEndpoint do
	use Plug.Router

	plug :match
	plug Plug.Parsers,
		 parsers: [:urlencoded, :multipart, :json],
		 pass: ["text/*", "multipart/*", "application/json", "application/x-www-form-urlencoded"],
		 json_decoder: Jason
	plug :dispatch

	match _ do
		HttpHandler.call(conn.method, conn.request_path, conn)
	end
end
