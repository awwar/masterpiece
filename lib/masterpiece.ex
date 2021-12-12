defmodule Masterpiece do
	def get_data do
		Jason.encode!(
			[
				%{
					layout_name: :ad234234,
					endpoints: %{
						"http" => %{
							route: "/test3",
							method: "POST"
						}
					},
					map: %{
						node_input_1: %{
							1 => :conn,
						},
						scope_1: %{
							scope: :if,
							options: %{
								condition: true,
								true: %{
									node_addition_1: %{
										1 => %{
											name: :node_input_1,
											path: [:body, "a"]
										},
										2 => %{
											name: :node_input_1,
											path: [:body, "b"]
										},
									},
									scope_2: %{
										scope: :if,
										options: %{
											condition: [%{name: :node_input_1, path: [:body, "a"]}, "===", "11"],
											true: %{
												node_output_1: %{
													1 => :conn,
													2 => %{
														name: :node_addition_1,
														path: [:result]
													},
												},
											},
											false: %{
												number_node_2: %{},
												node_output_1: %{
													1 => :conn,
													2 => %{
														name: :number_node_2,
														path: [:result]
													},
												},
											}
										},
									},
								},
								false: %{
									number_node_1: %{},
									node_output_1: %{
										1 => :conn,
										2 => %{
											name: :number_node_1,
											path: [:result]
										},
									},
								}
							}
						}
					},
					nodes: %{
						node_input_1: %{
							pattern: :http_input_node,
							option: %{},
						},
						number_node_1: %{
							pattern: :number_node,
							option: %{
								"value" => -1000
							},
						},
						number_node_2: %{
							pattern: :number_node,
							option: %{
								"value" => -2000
							},
						},
						node_output_1: %{
							pattern: :http_output_node,
							option: %{
								"encode" => "text"
							},
						},
						node_addition_1: %{
							pattern: :addition_node,
							option: %{},
						},
					}
				}
			]
		)
	end
end
