defmodule NodeReferenceParser do
	def parse(name) do
		%Types.NodeReference {
			name: CompilerHelper.to_atom(name)
		}
	end
end
