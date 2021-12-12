defmodule ExtendMap do
	def get_in!(data, []), do: data

	def get_in!(data, [h | t]) when is_map_key(data, h), do: get_in!(data[h], t)
	def get_in!(data, [h | _]), do: raise "Key '#{h}' does not exists in: " <> Kernel.inspect(data)
end
