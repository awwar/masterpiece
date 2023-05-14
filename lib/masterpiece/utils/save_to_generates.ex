defmodule SaveToGenerates do
  def execute(content, name) do
    File.open(
      File.cwd!() <> "/generates/#{name}",
      [:write],
      fn file -> IO.puts file, content end
    )
  end
end
