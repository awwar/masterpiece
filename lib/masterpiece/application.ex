path = "./flows.yaml"
#{:ok, content} = Path.join(File.cwd!(), path)
#				 |> File.read()
#
#"." <> extension = Path.extname(path)
#
#content
#|> RawConfigParser.parse(extension)
#|> LayoutParser.parse
#|> AppCompiler.compile
{:ok, content} = Path.join(File.cwd!(), path)
				 |> File.read()

"." <> extension = Path.extname(path)

content
|> RawConfigParser.parse(extension)
|> ConfigParser.parse
|> AppCompiler.compile