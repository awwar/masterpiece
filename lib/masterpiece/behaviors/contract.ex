defmodule Behaviors.Contract do
  @type t :: module

  @callback create(settings :: term) :: term
end
