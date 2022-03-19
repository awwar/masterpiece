defmodule TestGenerates do
	def execute(name, module_content) do
		{:ok, file} = File.open(File.cwd!() <> "/generates/#{name}.ex", [:write])

		IO.puts file,
				Macro.to_string(
					quote do
						defmodule unquote(String.to_atom(name)) do
							unquote(module_content)
						end
					end
				)

		File.close(file)
	end
end
