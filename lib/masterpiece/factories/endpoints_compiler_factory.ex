defmodule EndpointsCompilerFactory do
	def create(%Types.Endpoints.Http{}) do
		HttpHandlerCompiler.compile(data)
	end

	def create(name, _) do
		raise "Undefined compiler " <> name
	end
end
