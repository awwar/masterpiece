defmodule EndpointCompiler do
	def compile(endpoints) do
		endpoints |> Enum.filter(& &1.name === :http) |> HttpEndpointCompiler.compile
	end
end
