defmodule EndpointsCompilerFactory do
	def create(:http, data) do
		HttpHandlerCompiler.compile(data)
	end

	def create(name, _) do
		raise "Undefined compiler " <> name
	end
end
