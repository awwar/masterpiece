defmodule NodePatternFactory do
  def create("addition_node"), do: NodePatterns.AdditionNode
  def create("number_node"), do: NodePatterns.NumberNode

  def create(name), do: raise("Undefined node pattern #{name}")
end

defmodule NodePatternFactoryTest do
  use ExUnit.Case

  test "when addition_node" do
    assert NodePatternFactory.create("addition_node") == NodePatterns.AdditionNode
  end
end
