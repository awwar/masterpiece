defmodule NodeInputParser do

	def parse(%{"variable" => variable, "path" => path}) do
		%Types.NodeInput{
			type: :object,
			value: CompilerHelper.to_atom(variable),
			path: map_path(path)
		}
	end

	def parse(%{"node" => node_name, "path" => path}) do
		%Types.NodeInput{
			type: :node,
			value: NodeReferenceParser.parse(node_name),
			path: map_path(path)
		}
	end

	def parse(%{"value" => value}) do
		%Types.NodeInput{type: :value, value: value, path: []}
	end

	def parse(context),
		do: raise "Unexpected input`s context, got: " <> Kernel.inspect(context)

	defp map_path([]), do: []
	defp map_path([key | rest]), do: [CompilerHelper.to_atom(key)] ++ rest
end
