defmodule ScopePatterns.IfScope do
    def get_content(
            %{
                condition: cond,
                true: true_map,
                false: false_map,
            }
        ) do
        quote do
            if(unquote(cond)) do
                unquote({:__block__, [], RunnerContentCompiler.compile(true_map)})
            else
                unquote({:__block__, [], RunnerContentCompiler.compile(false_map)})
            end
        end
    end

    def parse_options(%{"true" => true_map, "condition" => cond, "false" => false_map}) do
        %{
            condition: ConditionParser.parse(cond),
            true: MapParser.parse(true_map),
            false: MapParser.parse(false_map),
        }
    end

    def pull_dependencies(%{true: true_line, false: false_line}) do
        NodeSorter.pull(true_line) ++ NodeSorter.pull(false_line)
    end
end
