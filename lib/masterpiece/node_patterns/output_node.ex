defmodule NodePatterns.OutputNode do
  @behaviour Behaviors.MapEntity

  def get_content(%{
        output_fields: output_fields
      }) do
    input = Enum.map(output_fields, &Macro.var(&1, nil))

    output =
      Enum.map(output_fields, &{&1, Macro.var(&1, nil)})
      |> Keyword.new()
      |> then(&{:%{}, [], &1})

    quote do
      def execute(unquote_splicing(input)) do
        {true, unquote(output)}
      end
    end
  end

  def parse_options(output_fields) do
    %{
      output_fields:
        Enum.map(
          output_fields,
          fn
            k when is_atom(k) -> k
            k -> raise "Output field must be a atom, got: " <> inspect(k)
          end
        )
    }
  end
end
