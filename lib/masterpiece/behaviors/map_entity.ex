defmodule Behaviors.MapEntity do
  @type t :: module

  @type options :: Keyword.t()

  @callback get_content(options) :: {Atom.t(), List.t(), List.t()}
  @callback parse_options(options) :: options
end
