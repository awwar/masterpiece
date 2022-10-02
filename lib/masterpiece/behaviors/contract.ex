defmodule Behaviors.Contract do
	@type t :: module

	@callback parse(data, setting) :: term
end
