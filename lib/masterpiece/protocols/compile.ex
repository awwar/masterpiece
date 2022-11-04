defprotocol Protocols.Compile do
	def compile(data)
end

defimpl Protocols.Compile, for: Any do
	def compile(data), do: raise "No protocol found for " <> Kernel.inspect(data)
end