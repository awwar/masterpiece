defmodule Types.Flow do
	defstruct [
		flow_name: "",
		nodes: %{},
		map: [],
		sockets: [],
		input: [],
		output: []
	]
end

defimpl Protocols.Compile, for: Types.Flow do
	alias Types.Flow
	alias NodePatterns.OutputNode


	def compile(%Flow{flow_name: flow_name, nodes: nodes, map: map, sockets: sockets, input: input, output: output}) do
		Enum.each(nodes, &Protocols.Compile.compile/1)

		input_names = Enum.map(input, & &1.name)
		output_names = Enum.map(output, & &1.name)

		runner_content = RunnerContentCompiler.compile(sockets, map)

		Protocols.Compile.compile(
			%Types.Node{
				name: :output,
				pattern: OutputNode,
				options: OutputNode.parse_options(output_names)
			}
		)

		input_args = Enum.map(input_names, &Macro.var(&1, nil))

		module_content = quote do
			def execute(unquote_splicing(input_args)), do: unquote(runner_content)
			def get_input(), do: unquote(input_names)
			def get_output(), do: unquote(output_names)
		end

		TestGenerates.execute(Atom.to_string(flow_name), module_content)

		Module.create(flow_name, module_content, Macro.Env.location(__ENV__))
	end
end
