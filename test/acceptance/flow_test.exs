defmodule FlowTest do
  use ExUnit.Case

  @moduletag :capture_log

  test "when a = 1; b = 13;" do
    :additional_endpoint_flow.execute(%:flow_input_cm{value: %{"a" => 11, "b" => 13}})
    |> then(&(&1 === {true, %{code: 200, content_type: "json", data: -1000}}))
    |> assert
  end
end
