defmodule Types.Endpoints.Http do
	defstruct [
		name: "",
		route: "/",
		method: "GET",
		flow: "",
		encode: :text
	]
end
