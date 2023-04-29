defmodule Types.Contract do
  defstruct name: "",
            extends: "",
            settings: %{},
            cast_to: []
end

defimpl Protocols.Compile, for: Types.Contract do
  alias Types.Contract

  def compile(
    %Contract{name: name, extends: extends, cast_to: cast_to, settings: settings},
    %{parent_casts: parent_casts}
  ) do
    construct_module_name = name |> as_contract_module_name
    quote do
      defstruct [:value]
      def name, do: unquote(name)
      def extends, do: unquote(extends)
      def settings, do: unquote(Macro.escape settings)
      def constructor(value), do: %unquote(construct_module_name){value: value}
      unquote_splicing(parent_casts |> Enum.map(fn {cast_to_name, parent_name} -> compile_cast_callback(parent_name, cast_to_name) end))
      unquote_splicing(cast_to |> Enum.map(fn cast_to_name -> compile_cast_callback(name, cast_to_name) end))
    end
    |> TestGenerates.execute(construct_module_name)
    |> compile_module(name)
  end

  defp compile_cast_callback(contract_name, cast_to_name) do
    cast_node_name = String.to_atom("#{contract_name}_#{cast_to_name}_cast_node")
    quote do
      def cast_to(contract_struct, unquote(cast_to_name)) do
        with {true, result} = unquote(cast_node_name).execute(contract_struct) do
          result
        end
      end
    end
  end

  defp compile_module(content, name) do
    name
    |> as_contract_module_name
    |> Module.create(content, Macro.Env.location(__ENV__))
    |> then(fn {:module, module, _, _} -> module end)
  end

  defp as_contract_module_name(name) when is_binary(name) or is_atom(name),
       do: "#{name}_contract_module" |> String.to_atom
end
