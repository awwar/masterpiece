defmodule Types.ScopeSocket do
    defstruct [:id, :scope, :options]
end

defimpl Protocols.Compile, for: Types.ScopeSocket do
    def compile(%Types.ScopeSocket{scope: scope, options: options}, _) do
        node_call = scope.get_content(options)

        quote do
            unquote({:ctrl_code, [], nil}) = unquote(node_call)
        end
    end
end