defmodule ScopePatterns.ThenScope do
    def get_content(
            %{
                left: left_map,
                right: right_map,
            }
        ) do
        quote do
            unquote({:__block__, [], RunnerContentCompiler.compile(left_map, [])})
            unquote({:__block__, [], RunnerContentCompiler.compile(right_map, [])})
        end
    end

    def parse_options(%{"left" => left_map, "right" => right_map}) do
        %{
            left: MapParser.parse(left_map),
            right: MapParser.parse(right_map),
        }
    end

    def pull_dependencies(%{left: left_map, right: right_map}) do
        NodeSorter.pull(left_map) ++ NodeSorter.pull(right_map)
    end
end
