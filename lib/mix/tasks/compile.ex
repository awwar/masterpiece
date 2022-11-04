defmodule Mix.Tasks.Mtp.Compile do
	use Mix.Task

	def run(params) do
		case OptionParser.parse(params, switches: [config: :string]) do
			{[config: path], _, _} -> do_compile(path)
			_ -> IO.warn("Path to config is empty! Use: mix mtp.compile --config <path to config>")
		end
	end

	def do_compile(path) do
		{:ok, content} = Path.join(File.cwd!(), path)
						 |> File.read()

		"." <> extension = Path.extname(path)

		content
		|> RawConfigParser.parse(extension)
		|> ConfigParser.parse
		|> AppCompiler.compile
	end
end
