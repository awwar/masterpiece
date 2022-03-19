defmodule NodeInputParser do

	def parse(%{"variable" => variable, "path" => [key | rest]}) do
		%Types.NodeInput{
			type: :object,
			value: CompilerHelper.to_atom(variable),
			path: [CompilerHelper.to_atom(key)] ++ rest
		}
	end

	def parse(%{"node" => node_name, "path" => [key | rest]}) do
		%Types.NodeInput{
			type: :node,
			value: NodeReferenceParser.parse(node_name),
			path: [CompilerHelper.to_atom(key)] ++ rest
		}
	end

	def parse(param) do
		%Types.NodeInput{type: :value, value: param, path: []}
	end

	def parse(context),
		do: raise "Unexpected input`s context, got: " <> Kernel.inspect(context)
end
