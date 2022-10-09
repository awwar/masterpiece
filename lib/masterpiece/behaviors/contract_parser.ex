defmodule Behaviors.Contract.Parser do
	@type t :: module

	@callback execute(term) :: term
end
