defmodule ContractFactory do
	def create("string"), do: Contacts.String
	def create("numeric_string"), do: Contacts.NumericString
	def create("object"), do: Contacts.Object
	def create("list"), do: Contacts.List
end
