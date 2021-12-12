defmodule NumberParserTest do
	use ExUnit.Case
	doctest Masterpiece

	test "positive integer" do
		assert NumberParser.parse(11) == 11
	end

	test "negative integer" do
		assert NumberParser.parse(-11) == -11
	end

	test "positive float" do
		assert NumberParser.parse(11.2) == 11.2
	end

	test "negative float" do
		assert NumberParser.parse(-11.2) == -11.2
	end

	test "positive integer string" do
		assert NumberParser.parse("11") == 11
	end

	test "negative integer string" do
		assert NumberParser.parse("-11") == -11
	end

	test "positive float string" do
		assert NumberParser.parse("11.2") == 11.2
	end

	test "negative float string" do
		assert NumberParser.parse("-11.2") == -11.2
	end

	test "text" do
		assert_raise RuntimeError, "Expected a numeric, got: 'asd'", fn ->
			NumberParser.parse("asd")
		end
	end

	test "text with integer" do
		assert_raise RuntimeError, "Expected a numeric, got: '123asd'", fn ->
			NumberParser.parse("123asd")
		end
	end

	test "text with float" do
		assert_raise RuntimeError, "Expected a numeric, got: '0.2asd'", fn ->
			NumberParser.parse("0.2asd")
		end
	end

	test "non binary and number entity" do
		assert_raise RuntimeError, "Got unexpected entity: %{a: \"b\"}", fn ->
			NumberParser.parse(%{a: "b"})
		end
	end
end
