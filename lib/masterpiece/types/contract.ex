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
      def settings, do: unquote(Macro.escape settings)
      unquote_splicing(parent_casts |> Enum.map(fn {cast_to_name, parent_name} -> compile_cast_callback(parent_name, cast_to_name) end))
      unquote_splicing(cast_to |> Enum.map(fn cast_to_name -> compile_cast_callback(name, cast_to_name) end))
    end
    |> TestGenerates.execute(name)
    |> compile_module(name)
  end

  defp compile_cast_callback(contract_name, cast_to_name) do
    quote do
      def cast_to(value, unquote(cast_to_name)), do:
        unquote(String.to_atom("#{contract_name}_#{cast_to_name}_cast_node")).execute(value)
    end
  end

  defp compile_module(content, name) do
    name
    |> then(fn
      part when is_atom(part) -> Atom.to_string(part) <> "_contract_module"
      part when is_binary(part) -> part <> "_contract_module"
    end)
    |> String.to_atom()
    |> Module.create(content, Macro.Env.location(__ENV__))
    |> then(fn {:module, module, _, _} -> module end)
  end
end
