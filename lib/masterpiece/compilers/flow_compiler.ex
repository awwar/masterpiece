defmodule FlowCompiler do
	alias NodePatterns.OutputNode
	alias Types.Flow

	def compile(%Flow{flow_name: flow_name, nodes: nodes, map: map, sockets: sockets, input: input, output: output}) do
		Enum.each(nodes, fn {name, context} -> NodeCompiler.compile(name, context) end)

		runner_content = RunnerContentCompiler.compile(sockets, map)

		NodeCompiler.compile(
			:output,
			%{
				pattern: OutputNode,
				option: OutputNode.parse_options(output)
			}
		)

		input_args = Enum.map(input, &Macro.var(&1, nil))

		module_content = quote do
			def execute(unquote_splicing(input_args)), do: unquote(runner_content)
			def get_input(), do: unquote(input)
			def get_output(), do: unquote(output)
		end

		TestGenerates.execute(Atom.to_string(flow_name), module_content)

		Module.create(flow_name, module_content, Macro.Env.location(__ENV__))
	end
end
