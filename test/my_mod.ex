defmodule MyMod do
    def(run(%{http: conn})) do
        execute(conn)
    end
    def(run(%{kafka: conn})) do
        execute(conn)
    end
    defp(execute(conn)) do
        {ctrl_code, node_input_1_result} = :node_input_1.execute(conn)
        case(ctrl_code) do
            :exit ->
                IO.puts("Program ends")
            _ ->
                {ctrl_code, _} = {true == true, {}}
                case(ctrl_code) do
                    :exit ->
                        IO.puts("Program ends")
                    _ ->
                        {ctrl_code, number_node_1_result} = :number_node_1.execute()
                        case(ctrl_code) do
                            :exit ->
                                IO.puts("Program ends")
                            _ ->
                                {ctrl_code, node_output_1_result} = :node_output_1.execute(
                                    conn,
                                    ExtendMap.get_in!(number_node_1_result, [:result])
                                )
                                case(ctrl_code) do
                                    :exit ->
                                        IO.puts("Program ends")
                                    _ ->
                                        IO.puts("Program ends")
                                end
                        end
                end
        end
    end
end
