defmodule Types.App do
	defstruct [
		endpoints: [],
		contracts: [],
		flows: [],
	]
end

defimpl Protocols.Compile, for: Types.App do
	alias Types.App
	import CompilerHelper

	def compile(%App{flows: flows, endpoints: endpoints, contracts: contracts}) do
		contracts++ [
			%Contract{name: :string},
			%Contract{name: :integer},
			%Contract{name: :bool},
			%Contract{name: :float},
			%Contract{name: :list},
			%Contract{name: :numeric_string},
			%Contract{name: :object},
		] |> Enum.each(&as_ast/1)
		Enum.each(flows, &as_ast/1)
		Enum.each(endpoints, &as_ast/1)
		endpoints
		|> Enum.map(&get_process_config/1)
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

	defp get_process_config(%Types.EndpointGroup{name: :http}) do
		{
			Plug.Cowboy,
			scheme: :http,
			plug: HttpEndpoint,
			options: [
				port: 8080
			]
		}
	end

	defp get_process_config(name) do
		raise "Undefined application " <> inspect(name)
	end
end
