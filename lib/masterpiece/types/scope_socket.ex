defmodule Types.ScopeSocket do
	defstruct [:id, :scope, :options]
end

defimpl Protocols.Compile, for: Types.ScopeSocket do
	alias Types.ScopeSocket

	def compile(%ScopeSocket{scope: scope, options: options}) do
		node_call = scope.get_content(options)

		quote do
			unquote({:ctrl_code, [], nil}) = unquote(node_call)
		end
	end
end