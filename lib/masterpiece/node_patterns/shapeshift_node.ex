defmodule NodePatterns.ShapeshiftNode do
    alias Types.NodeConfig

    def get_config do
        %NodeConfig{
            input: :dynamic,
            output: :dynamic,
            option: %{
                nodes: :list,
                output: :map,
                input: :list,
            }
        }
    end

    def get_content(
            %{
                "output" => output,
                "input" => input
            },
            body
        ) do
        outputs = Enum.map(
                      output,
                      fn {o_name, o_content} ->
                          {
                              :"#{o_name}_result",
                              CompilerHelper.create_argument_variable(
                                  %Types.NodeInput{name: o_name, path: [String.to_atom(o_content)]}
                              )
                          }
                      end
                  )
                  |> then(&{:%{}, [], &1})

        inputs = Enum.map(
            input,
            fn name -> Macro.var(name, __MODULE__) end
        )

        full_body = body ++ [outputs]

        quote do
            def execute(unquote_splicing(inputs)) do
                unquote({:__block__, [], full_body})
            end
        end
    end

    def parse_options(
            %{
                "name" => node_name,
                "output" => output,
                "input" => input
            }
        ) do
        %{
            "name" => node_name,
            "output" => output,
            "input" => input
        }
    end
end