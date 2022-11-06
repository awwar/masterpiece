defmodule Types.ScopeSocket do
	defstruct [:id, :scope, :options]
end

defimpl Protocols.Compile, for: Types.ScopeSocket do
	alias Types.ScopeSocket

	def compile(%ScopeSocket{id: id, scope: scope, options: options}) do
		node_call = scope.get_content(options)

		quote do
			ctrl_code = unquote(node_call)
		end
	end
end