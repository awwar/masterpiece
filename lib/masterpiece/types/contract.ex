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
    quote do
      defstruct [:value]
      def name, do: unquote(name)
      def extends, do: unquote(extends)
      def settings, do: unquote(Macro.escape(settings))
      def constructor(value), do: %unquote(name){value: value}

      unquote_splicing(
        parent_casts
        |> Enum.map(fn {cast_to_name, parent_name} ->
          delegate_parent_callbacks(parent_name, cast_to_name)
        end)
      )

      unquote_splicing(
        cast_to
        |> Enum.map(fn cast_to_name -> compile_cast_callback(name, cast_to_name) end)
      )
    end
    |> TestGenerates.execute(name)
    |> compile_module(name)
  end

  defp compile_cast_callback(contract_name, cast_to_name) do
    cast_node_name = String.to_atom("#{contract_name}_#{cast_to_name}_cast_node")

    quote do
      def cast_to(contract_struct, unquote(cast_to_name)) do
        case unquote(cast_node_name).execute(contract_struct) do
          {true, result} ->
            result

          rez ->
            raise "Unable to cast from #{unquote(contract_name)} to #{unquote(cast_to_name)}, got #{inspect(rez)}"
        end
      end
    end
  end

  defp delegate_parent_callbacks(contract_name, cast_to_name) do
    quote do
      def cast_to(contract_struct, unquote(cast_to_name)),
        do: unquote(contract_name).cast_to(contract_struct, unquote(cast_to_name))
    end
  end

  defp compile_module(content, name) do
    name
    |> Module.create(content, Macro.Env.location(__ENV__))
    |> then(fn {:module, module, _, _} -> module end)
  end
end
