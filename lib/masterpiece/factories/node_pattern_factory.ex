defmodule NodePatternFactory do
    def create("addition_node"), do: NodePatterns.AdditionNode
    def create("http_input_node"), do: NodePatterns.HttpInputNode
    def create("http_output_node"), do: NodePatterns.HttpOutputNode
    def create("number_node"), do: NodePatterns.NumberNode

    def create(name), do: raise "Undefined node pattern #{name}"
end
