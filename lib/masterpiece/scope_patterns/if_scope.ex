defmodule ScopePatterns.IfScope do
    def get_content(
            %{
                condition: %Types.Condition{
                    left: left,
                    method: method,
                    right: right
                },
            }
        ) do
        cond = case method do
            nil -> {:===, [], [left, left]}
            method -> {":" <> method, [], [left, right]}
        end

        quote do
            {unquote(cond), {}}
        end
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
