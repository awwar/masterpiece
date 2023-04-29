defmodule ContractParserTest do
    use ExUnit.Case

    @moduletag :capture_log

    test "negative integer" do
      :integer_contract_module.constructor(1234)
      |> :integer_contract_module.cast_to(:string)
      |> then(& &1 === %:string_contract_module{value: "1234"})
      |> assert
    end

    test "json" do
      :json_contract_module.constructor("{\"asd\":123}")
      |> :json_contract_module.cast_to(:map)
      |> then(& &1 === %:map_contract_module{value: %{"asd" => 123}})
      |> assert
    end
end
