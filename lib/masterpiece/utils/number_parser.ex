defmodule NumberParser do
    def parse(a) when is_number(a), do: a

    def parse(a) when is_binary(a) do
        {number, rest} = Integer.parse(a)
        confirm(number, rest)
    rescue
        _ -> raise "Expected a numeric, got: '#{a}'"
    end

    def parse(entity), do: raise "Got unexpected entity: " <> Kernel.inspect(entity)

    defp confirm(number, ""), do: number
    defp confirm(number, <<?., rest :: binary>>), do: get_full_float(number, :erlang.binary_to_float("0." <> rest))
    defp confirm(_, _), do: raise "Got unexpected number"

    defp get_full_float(number, mantissa) when number < 0, do: number - mantissa
    defp get_full_float(number, mantissa), do: number + mantissa
end
