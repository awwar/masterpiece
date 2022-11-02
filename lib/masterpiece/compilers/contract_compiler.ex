defmodule ContractCompiler do
#	def compile([%Types.Contract.Base{pattern: pattern, settings: settings} | rest], compiled), do:
#		do_compile(:erlang.phash2(settings) <> pattern, pattern, settings, compiled)
#
#	defp do_compile(name, _, _, compiled) when name in compiled, do: _
#	defp do_compile(name, pattern, settings, compiled) do
#
#	end
end
