defmodule Types.Node do
	defstruct [:name, :pattern, :options]
end

defimpl Protocols.Compile, for: Types.Node do
	alias Types.Node

	def compile(%Node{name: name, pattern: pattern, options: options}, _) do
    TestGenerates.execute(pattern.get_content(options), Atom.to_string(name))
		Module.create(name, pattern.get_content(options), Macro.Env.location(__ENV__))
	end
end
