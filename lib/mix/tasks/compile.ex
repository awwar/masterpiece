defmodule Mix.Tasks.Mtp.Compile do
	use Mix.Task

	def run(params) do
		with {[config: path], _, _} <- OptionParser.parse(
			params,
			switches: [
				config: :string
			]
		) do
			{:ok, content} = Path.join(File.cwd!(), path)
							 |> File.read()

			"." <> extension = Path.extname(path)

			content
			|> RawConfigParser.parse(extension)
			|> FlowParser.parse
			|> Enum.map(&FlowCompiler.compile(&1))

#			IEx.Helpers.recompile(force: true)
		else
			_ -> IO.warn("Path to config is empty! Use: mix mtp.compile --config <path to config>")
		end
	end
end
