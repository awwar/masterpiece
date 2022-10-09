defmodule ContractParserTest do
	use ExUnit.Case

	@moduletag :capture_log

	test "negative integer" do
		parser = Contacts.NumericString.create(%{})

		result = parser.execute("-123")

		assert -123 === result
	end

	test "negative float" do
		parser = Contacts.NumericString.create(%{})

		result = parser.execute("-123.3")

		assert -123.3 === result
	end

	test "negative float with comma" do
		parser = Contacts.NumericString.create(%{})

		result = parser.execute("-1.23e7")

		assert -1.23e7 === result
	end
end
