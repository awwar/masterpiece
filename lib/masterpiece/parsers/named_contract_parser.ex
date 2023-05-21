defmodule NamedContractParser do
  @contact_module_suffix "_cm"

  def parse(contracts) when is_list(contracts), do: Enum.map(contracts, &parse(&1))

  def parse(
        %{
          "name" => name,
          "contract" => contract
        }
      ), do: %Types.NamedContract{
        name: String.to_atom(name),
        contract: contract |> to_cm_name,
      }

  def parse(options), do: raise "Named Contract is invalid, got: " <> Kernel.inspect(options)

  defp to_cm_name(name),
       do: name
           |> String.replace_suffix(@contact_module_suffix, @contact_module_suffix)
           |> String.replace_suffix("", @contact_module_suffix)
           |> CompilerHelper.to_atom()
end
