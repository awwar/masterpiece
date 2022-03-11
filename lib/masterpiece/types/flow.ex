defmodule Types.Flow do
	defstruct [
		flow_name: "",
		nodes: %{},
		map: [],
		sockets: [],
		input: [],
		output: []
	]
end
