defmodule Types.SocketReference do
    defstruct [:id]

    def from_binary(id) when is_binary(id), do: %Types.SocketReference{id: id}

    def to_binary(%Types.SocketReference{id: id}) when is_binary(id), do: id
end
