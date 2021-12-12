defmodule NodeCompiler do

	@spec compile(String.t, %{pattern: Behaviors.MapEntity.t, option: Keyword.t}) :: String.t()
	def compile(node_name, %{pattern: pattern, option: option}) do
		Module.create(node_name, pattern.get_content(option), Macro.Env.location(__ENV__))
	end
end
