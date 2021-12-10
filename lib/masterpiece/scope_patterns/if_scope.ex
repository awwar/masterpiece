defmodule ScopePatterns.IfScope do
    def get_content(
            %{
                condition: condition,
            }
        ) do
        ConditionCompiler.compile(condition)
    end

    def parse_options(%{"condition" => cond}) do
        %{
            condition: ConditionParser.parse(cond)
        }
    end

    def pull_dependencies(%{true: true_line, false: false_line}) do
        NodeSorter.pull(true_line) ++ NodeSorter.pull(false_line)
    end
end
