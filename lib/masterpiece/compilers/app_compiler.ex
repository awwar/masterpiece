defmodule AppCompiler do
	def compile(objects) do
		Enum.filter(objects, fn object -> object.__struct__ == Types.Flow end)
		|> compile_flows

		Enum.filter(objects, fn object -> object.__struct__ == Types.Endpoint end)
		|> compile_endpoints
		|> compile_application
	end

	defp compile_flows(flows) do
		Enum.each(flows, &FlowCompiler.compile(&1))
	end

	defp compile_endpoints(endpoints) do
		endpoints
		|> Enum.map_reduce(%{}, &{&1, Map.put(&2, &1.name, Map.get(&2, &1.name, []) ++ [&1])})
		|> then(fn {_, group} -> group end)
		|> tap(&Enum.each(&1, fn {name, endpoints} -> EndpointsCompilerFactory.create(name, endpoints) end))
		|> Enum.map(fn {name, _} -> EndpointsApplicationsFactory.create(name) end)
	end

	defp compile_application(endpoint_applications) do
		quote do
			use Application

			import Supervisor.Spec, warn: false

			def start(_type, _args) do
				children = unquote(Macro.escape(endpoint_applications))

				Supervisor.start_link children, [strategy: :one_for_one, name: Proxy.Supervisor]
			end
		end
		|> then(&Module.create(Masterpiece.Application, &1, Macro.Env.location(__ENV__)))
	end
end
