defmodule Types.NamedContract do
  defstruct [
    name: "",
    contract: ""
  ]

  defimpl Protocols.Compile do
    def compile(%Types.NamedContract{name: name, contract: contract}, _) do
      {:=, [], [{:%, [], [contract, {:%{}, [], []}]}, {name, [], nil}]}
    end
  end
end
