defmodule NodeInputParser do
	def parse(param) when is_binary(param) do
		%Types.NodeInput{type: :object, name: String.to_atom(param), path: []}
	end

	def parse(%{"name" => node_name, "path" => [key | rest]}) do
		%Types.NodeInput{type: :node, name: NodeReferenceParser.parse(node_name), path: [String.to_atom(key)] ++ rest}
	end

	def parse(context),
		do: raise "Unexpected input`s context, got: " <> Kernel.inspect(context)
end
