defmodule Behaviors.Contract do
	@type t :: module

	@callback create(term) :: term
end
