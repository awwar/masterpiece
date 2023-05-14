defmodule ContractParser do
  @contact_module_suffix "_cm"

  alias Types.Contract

  def parse(contracts) when is_list(contracts),
      do: contracts
          |> Enum.map(&parse(&1))

  def parse(%{"name" => name, "extends" => pattern} = setting),
      do: %Contract{
        name: name
              |> to_cm_name,
        extends: pattern
                 |> to_cm_name,
        settings: Map.get(setting, "settings", %{}),
        cast_to: setting
                 |> Map.get("cast_to", [])
                 |> then(&(&1 ++ [pattern]))
                 |> Enum.uniq
                 |> Enum.map(&to_cm_name/1)
                 |> Enum.filter(& &1 != :root_cm)
      }

  def parse(options), do: raise("Contract is invalid, got: " <> Kernel.inspect(options))

  defp to_cm_name(name),
       do: name
           |> String.replace_suffix(@contact_module_suffix, @contact_module_suffix)
           |> String.replace_suffix("", @contact_module_suffix)
           |> CompilerHelper.to_atom()
end
