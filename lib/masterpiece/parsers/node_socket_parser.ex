defmodule NodeSocketParser do
    def parse(name, inputs) do
        %Types.NodeSocket {
            name: String.to_atom(name),
            inputs: Enum.map(inputs, fn {_, value} -> parse_input(value) end)
        }
    end

    def parse_input(param) when is_binary(param) do
        String.to_atom(param)
    end

    def parse_input(%{"name" => node_name, "path" => [key | rest]}) do
        %Types.NodeInput{name: String.to_atom(node_name), path: [String.to_atom(key)] ++ rest}
    end

    def parse_input(context),
         do: raise "Unexpected input`s context, got: " <> Kernel.inspect(context)
end
