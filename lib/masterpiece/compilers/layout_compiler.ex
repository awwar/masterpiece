defmodule LayoutCompiler do
	def compile(%{layout_name: layout_name, nodes: nodes, map: map, sockets: sockets}) do
		Enum.each(
			nodes,
			fn {name, context} -> NodeCompiler.compile(name, context) end
		)

		runner_content = RunnerContentCompiler.compile(sockets, map)

		conn = Macro.var(:conn, nil)

		module_content = quote do
			def run(%{http: unquote(conn)}), do: execute(unquote(conn))

			def run(%{kafka: unquote(conn)}), do: execute(unquote(conn))

			defp execute(unquote(conn)), do: unquote(runner_content)
		end

		#                IO.inspect Macro.validate(runner_content)

		#                IO.inspect module_content

		#        IO.puts Macro.to_string(module_content)
		#                exit(0)


		{:ok, file} = File.open(File.cwd!() <> "/generates/" <> Atom.to_string(layout_name) <> ".ex", [:write])

		IO.puts file,
				Macro.to_string(
					quote do
						defmodule unquote(layout_name) do
							unquote(module_content)
						end
					end
				)

		File.close(file)

		Module.create(layout_name, module_content, Macro.Env.location(__ENV__))
	end
end
