import CompilerHelper

path = "./flows.yaml"

{:ok, content} =
  Path.join(File.cwd!(), path)
  |> File.read()

"." <> extension = Path.extname(path)

content
|> RawConfigParser.parse(extension)
|> ConfigParser.parse()
|> as_ast
