defmodule EndpointsApplicationsFactory do
	def create(:http) do
		{
			Plug.Cowboy,
			scheme: :http,
			plug: HttpEndpoint,
			options: [
				port: 8080
			]
		}
	end

	def create(name) do
		raise "Undefined application " <> name
	end
end
