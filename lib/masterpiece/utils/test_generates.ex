defmodule TestGenerates do
  def execute(module_content, name) do
    Macro.to_string(
      quote do
        defmodule unquote(String.to_atom(to_string(name))) do
          unquote(module_content)
        end
      end
    )
    |> SaveToGenerates.execute("#{name}.ex")

    module_content
  end
end
