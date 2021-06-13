defmodule ScopeParser do
    def parse(name, scope, options) do
        scope_pattern = ScopePatternFactory.create(scope)

        %Types.Scope {
            name: name,
            scope: scope_pattern,
            options: scope_pattern.parse_options(options)
        }
    end
end
