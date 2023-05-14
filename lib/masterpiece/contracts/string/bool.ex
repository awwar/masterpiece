defmodule :string_cm_bool_cm_cast_node do
  def execute(%:string_cm{value: ""}), do: {true, :bool_cm.constructor false}

  def execute(%:string_cm{value: _}), do: {true, :bool_cm.constructor true}

  def get_input do
    [:string_cm]
  end

  def get_output do
    [:bool_cm]
  end
end
