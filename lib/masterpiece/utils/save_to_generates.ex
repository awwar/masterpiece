defmodule SaveToGenerates do
	def execute(content, name) do
		{:ok, file} = File.open(File.cwd!() <> "/generates/#{name}", [:write])

		IO.puts file, content

		File.close(file)
	end
end
