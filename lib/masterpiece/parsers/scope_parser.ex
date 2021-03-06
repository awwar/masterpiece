defmodule ScopeParser do
	def parse(id, scope, options) do
		scope_pattern = ScopePatternFactory.create(scope)

		%Types.ScopeSocket {
			id: SocketReferenceParser.parse(id),
			scope: scope_pattern,
			options: scope_pattern.parse_options(options)
		}
	end
end
