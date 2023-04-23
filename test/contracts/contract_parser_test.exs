defmodule ContractParserTest do
    use ExUnit.Case

    @moduletag :capture_log

    test "negative integer" do
        Contacts.NumericString.module_name.factory("13.23")
        |> Protocols.Cast.cast("integer")
        |> then(& &1.value === 13)
        |> assert
    end

    test "json" do
      Contacts.Json.module_name.factory("{\"asd\":123}")
      |> Protocols.Cast.cast("map")
      |> then(& &1.value === %{"asd" => 123})
      |> assert
    end
    #
    #	test "negative float" do
    #		parser = Contacts.NumericString.create(%{})
    #
    #		result = parser.execute("-123.3")
    #
    #		assert -123.3 === result
    #	end
    #
    #	test "negative float with comma" do
    #		parser = Contacts.NumericString.create(%{})
    #
    #		result = parser.execute("-1.23e7")
    #
    #		assert -1.23e7 === result
    #	end
    #
    #	test "object of strings parser" do
    #		parser = Contacts.Object.create(
    #			[
    #				%{
    #					name: "a",
    #					contract: %{
    #						pattern: "string",
    #						settings: []
    #					}
    #				},
    #				%{
    #					name: "b",
    #					contract: %{
    #						pattern: "string",
    #						settings: []
    #					}
    #				},
    #			]
    #		)
    #
    #		example_object = %{a: "hello", b: "world"}
    #
    #		result = parser.execute(example_object)
    #
    #		assert example_object === result
    #	end
    #
    #	test "list of objects parser" do
    #		parser = Contacts.List.create(
    #			%{
    #				pattern: "object",
    #				settings: [
    #					%{
    #						name: "a",
    #						contract: %{
    #							pattern: "string",
    #							settings: []
    #						}
    #					},
    #					%{
    #						name: "b",
    #						contract: %{
    #							pattern: "string",
    #							settings: []
    #						}
    #					},
    #				]
    #			}
    #		)
    #
    #		example_object = [%{a: "hello", b: "world"}, %{a: "hello_2", b: "world_2"}]
    #
    #		result = parser.execute(example_object)
    #
    #		assert example_object === result
    #	end
end
