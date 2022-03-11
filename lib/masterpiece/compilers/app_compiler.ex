defmodule AppCompiler do
	def compile(objects) do
		Enum.filter(objects, fn object -> object.__struct__ == Type.Flow end)
		|> compile_flows

		Enum.filter(objects, fn object -> object.__struct__ == Type.Endpoint end)
		|> compile_endpoints
		|> compile_application
	end

	defp compile_flows(flows) do
		Enum.each(flows, &FlowCompiler.compile(&1))
	end

	defp compile_endpoints(endpoints) do
		Enum.map_reduce(
			endpoints,
			%{},
			fn %{name: name} = x, acc ->
				{x, Map.put(acc, name, Map.get(acc, name, []) ++ [x])}
			end
		)
		|> then(fn {_, group} -> group end)

		Enum.each(endpoints, &EndpointsCompilerFactory.create(&1))

		Enum.map(endpoints, fn %_{name: name} -> EndpointsApplicationsFactory.create(name) end)
	end

	defp get_endpoints_apps(all_endpoints) do
		Enum.map(
			all_endpoints,
			fn {endpoint_name, _} -> EndpointsApplicationsFactory.create(endpoint_name) end
		)
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
