defmodule ScopeParser do
    def parse(id, scope, options) do
        scope_pattern = ScopePatternFactory.create(scope)

        %Types.Scope {
            id: %Types.SocketReference{id: id},
            scope: scope_pattern,
            options: scope_pattern.parse_options(options)
        }
    end
end
