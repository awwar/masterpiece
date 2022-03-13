defmodule Types.Endpoint do
	defstruct [
		name: "",
		flow: "",
		options: %{},
		input_mapping: [],
		output_mapping: [],
	]
end
