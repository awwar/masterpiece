defmodule :http_connect_cm_map_cm_cast_node do
  def execute(%:http_connect_cm{value: value}),
    do:
      {true,
       :map_cm.constructor(%{
         query: Plug.Conn.Query.decode(value.query_string),
         body: value.body_params
       })}

  def get_input do
    [:http_connect_cm]
  end

  def get_output do
    [:map_cm]
  end
end
