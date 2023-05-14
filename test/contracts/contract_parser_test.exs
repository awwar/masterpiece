defmodule ContractParserTest do
    use ExUnit.Case

    @moduletag :capture_log

    test "integer to string parser" do
      :integer_cm.constructor(1234)
      |> :integer_cm.cast_to(:string_cm)
      |> then(& &1 === %:string_cm{value: "1234"})
      |> assert
    end

    test "json to map parser" do
      :json_cm.constructor("{\"asd\":123}")
      |> :json_cm.cast_to(:map_cm)
      |> then(& &1 === %:map_cm{value: %{"asd" => 123}})
      |> assert
    end

    test "float to integer parser" do
      :float_cm.constructor(123.11)
      |> :float_cm.cast_to(:integer_cm)
      |> then(& &1 === %:integer_cm{value: 123})
      |> assert
    end
end
