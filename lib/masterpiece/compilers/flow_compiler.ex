defmodule FlowCompiler do
	alias NodePatterns.OutputNode

	def compile(%{flow_name: flow_name, nodes: nodes, map: map, sockets: sockets, input: input, output: output}) do
		Enum.each(nodes, fn {name, context} -> NodeCompiler.compile(name, context) end)

		runner_content = RunnerContentCompiler.compile(sockets, map)

		NodeCompiler.compile(:output, %{pattern: OutputNode, option: OutputNode.parse_options(output)})

		module_content = quote do
			defp execute(unquote_splicing(input)), do: unquote(runner_content)
		end

		{:ok, file} = File.open(File.cwd!() <> "/generates/" <> Atom.to_string(flow_name) <> ".ex", [:write])

		IO.puts file,
				Macro.to_string(
					quote do
						defmodule unquote(flow_name) do
							unquote(module_content)
						end
					end
				)

		File.close(file)

		Module.create(flow_name, module_content, Macro.Env.location(__ENV__))
	end
end
