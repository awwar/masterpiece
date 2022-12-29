defprotocol Protocols.Cast do
	def cast(contract, to)
end

defimpl Protocols.Cast, for: Any do
	def cast(contract, to), do: raise "No Cast protocol found for " <> Kernel.inspect({contract, to})
end
