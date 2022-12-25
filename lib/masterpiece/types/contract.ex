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

	def compile(%Contract{name: "string"} = contract),
		do: compile_module(contract, Contacts.String)

	def compile(%Contract{name: "numeric_string"} = contract),
		do: compile_module(contract, Contacts.NumericString)

	def compile(%Contract{name: "object"} = contract),
		do: compile_module(contract, Contacts.Object)

	def compile(%Contract{name: "list"} = contract),
		do: compile_module(contract, Contacts.List)

	def compile(%Contract{name: name} = contract),
		do: compile_module(contract, Contacts.Custom)

	defp compile_module(%Contract{name: name, settings: settings}, compiler) do
		name
		|> then(& &1 <> 'contract_module')
		|> String.to_atom
		|> Module.create(compiler.create(settings), Macro.Env.location(__ENV__))
		|> then(fn {:module, module, _, _} -> module end)
	end

	defp compile_module(_, _), do: raise "Name must be a string"
end
