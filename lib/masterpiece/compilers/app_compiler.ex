defmodule AppCompiler do
	def compile(%Types.Config{flows: flows, endpoints: endpoints, contracts: contracts}) do
		ContractCompiler.compile(contracts)
		Enum.each(flows, &Protocols.Compile.compile/1)
		Enum.each(endpoints, &Protocols.Compile.compile/1)
		endpoints
		|> Enum.map(& &1.name)
		|> Enum.uniq
		|> Enum.map(&EndpointsApplicationsFactory.create/1)
		|> compile_application
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
