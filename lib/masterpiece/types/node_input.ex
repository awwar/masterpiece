defmodule Types.NodeInput do
  defstruct [:type, :value, path: []]
end

defimpl Protocols.Compile, for: Types.NodeInput do
  alias Types.NodeInput
  import CompilerHelper

  def compile(%NodeInput{type: :node, value: node_reference, path: out}, _),
    do:
      quote(
        do:
          ExtendMap.get_in!(
            unquote(
              as_ast(node_reference)
              |> Macro.var(nil)
            ),
            unquote(out)
          )
      )

  def compile(%NodeInput{type: :value, value: value}, _), do: value

  def compile(%NodeInput{type: :object, value: object_name, path: []}, _)
      when is_atom(object_name),
      do: Macro.var(object_name, nil)

  def compile(%NodeInput{type: :object, value: object_name, path: out}, _)
      when is_atom(object_name),
      do:
        quote(
          do:
            ExtendMap.get_in!(
              unquote(Macro.var(object_name, nil)),
              unquote(out)
            )
        )
end
