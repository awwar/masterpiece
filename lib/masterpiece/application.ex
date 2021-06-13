Masterpiece.get_data
|> Jason.decode!
|> LayoutParser.parse
|> AppCompiler.compile
#