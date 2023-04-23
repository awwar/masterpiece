defmodule TestGenerates do
  def execute(name, module_content) do
    Macro.to_string(
      quote do
        defmodule unquote(String.to_atom(name)) do
          unquote(module_content)
        end
      end
    )
    |> SaveToGenerates.execute("#{name}.ex")
  end
end
