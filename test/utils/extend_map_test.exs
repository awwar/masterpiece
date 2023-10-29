defmodule ExtendMapTest do
  use ExUnit.Case
  doctest Masterpiece

  @test_map %{
    "a" => %{
      b: %{
        "c" => 1
      }
    }
  }

  test "empty path" do
    assert ExtendMap.get_in!(@test_map, []) === @test_map
  end

  test "deep path" do
    assert ExtendMap.get_in!(@test_map, ["a", :b, "c"]) === 1
  end

  test "meddle path" do
    assert ExtendMap.get_in!(@test_map, ["a", :b]) === %{"c" => 1}
  end

  test "wrong path" do
    message =
      "Key 'c' does not exists in: " <>
        Kernel.inspect(%{
          b: %{
            "c" => 1
          }
        })

    assert_raise RuntimeError, message, fn ->
      ExtendMap.get_in!(@test_map, ["a", "c"])
    end
  end

  test "wrong key format" do
    message =
      "Key 'b' does not exists in: " <>
        Kernel.inspect(%{
          b: %{
            "c" => 1
          }
        })

    assert_raise RuntimeError, message, fn ->
      ExtendMap.get_in!(@test_map, ["a", "b"])
    end
  end
end
