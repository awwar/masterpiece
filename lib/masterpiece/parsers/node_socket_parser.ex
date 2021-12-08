defmodule NodeSocketParser do
    def parse(id, node_name, inputs) do
        %Types.NodeSocket {
            id: %Types.SocketReference{id: id},
            name: NodeReferenceParser.parse(node_name),
            inputs: Enum.map(inputs, fn {_, value} -> NodeInputParser.parse(value) end)
        }
    end
end
