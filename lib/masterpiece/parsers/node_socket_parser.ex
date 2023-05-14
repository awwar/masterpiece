defmodule NodeSocketParser do
  def parse(id, node_name, inputs) do
    %Types.NodeSocket {
      id: SocketReferenceParser.parse(id),
      name: NodeReferenceParser.parse(node_name),
      inputs: Enum.map(inputs, &NodeInputParser.parse(&1))
    }
  end
end
