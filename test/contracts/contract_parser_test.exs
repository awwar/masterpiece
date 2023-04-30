defmodule ContractParserTest do
    use ExUnit.Case

    @moduletag :capture_log

    test "integer to string parser" do
      :integer_contract_module.constructor(1234)
      |> :integer_contract_module.cast_to(:string)
      |> then(& &1 === %:string_contract_module{value: "1234"})
      |> assert
    end

    test "json to map parser" do
      :json_contract_module.constructor("{\"asd\":123}")
      |> :json_contract_module.cast_to(:map)
      |> then(& &1 === %:map_contract_module{value: %{"asd" => 123}})
      |> assert
    end

    test "float to integer parser" do
      :float_contract_module.constructor(123.11)
      |> :float_contract_module.cast_to(:integer)
      |> then(& &1 === %:integer_contract_module{value: 123})
      |> assert
    end
end
