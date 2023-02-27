defmodule Types.Contract do
    defstruct [
        name: "",
        extends: "",
        settings: %{},
        cast_from: []
    ]
end

defimpl Protocols.Compile, for: Types.Contract do
    alias Types.Contract

    def compile(%Contract{name: :bool} = contract),
        do: compile_module(contract, Contacts.Bool)

    def compile(%Contract{name: :float} = contract),
        do: compile_module(contract, Contacts.Float)

    def compile(%Contract{name: :integer} = contract),
        do: compile_module(contract, Contacts.Integer)

    def compile(%Contract{name: :numeric_string} = contract),
        do: compile_module(contract, Contacts.NumericString)

    def compile(%Contract{name: :string} = contract),
        do: compile_module(contract, Contacts.String)

    def compile(%Contract{name: :json} = contract),
        do: compile_module(contract, Contacts.Json)

    def compile(%Contract{extends: extends} = contract),
        do: compile(%Contract{name: extends, extends: extends})

    def compile(arg),
        do: raise inspect(arg)

    defp compile_module(%Contract{name: name, settings: settings}, compiler) do
        name
        |> then(
               fn
                   part when is_atom(part) -> Atom.to_string(part) <> "_contract_module"
                   part when is_binary(part) -> part <> "_contract_module"
               end
           )
        |> String.to_atom
        |> Module.create(compiler.create(settings), Macro.Env.location(__ENV__))
        |> then(fn {:module, module, _, _} -> module end)
    end

    defp compile_module(_, _), do: raise "Name must be a string"
end
