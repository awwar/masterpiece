defmodule NodeReferenceParser do
    def parse(name) do
        %Types.NodeReference {
            name: do_parse(name)
        }
    end

    defp do_parse(name) when is_atom(name), do: name

    defp do_parse(name), do: String.to_atom(name)
end
