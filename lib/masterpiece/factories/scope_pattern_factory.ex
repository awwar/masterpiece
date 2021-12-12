defmodule ScopePatternFactory do
	def create("if"), do: ScopePatterns.IfScope

	def create(name), do: raise "Undefined scope pattern #{name}"
end
