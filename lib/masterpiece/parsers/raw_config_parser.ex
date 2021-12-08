defmodule RawConfigParser do
  def parse(data, "json"), do: Jason.decode! data
  def parse(data, "yaml") do
      YamlElixir.read_from_string(data) |> then(fn
                                             {:ok, value} -> value
                                             _ -> "Unable to parse yaml config"
                                           end)
  end

  def parse(_, format), do: raise "Unknown config format \"#{format}\""
end
