defprotocol Protocols.Compile do
  def compile(data, context)
end

defimpl Protocols.Compile, for: Any do
  def compile(data, context),
    do: raise("No Compile protocol found for #{inspect(data)} and context #{inspect(context)}")
end
