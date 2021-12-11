path = "./layouts.yaml"
{:ok, content} = Path.join(File.cwd!(), path)
                 |> File.read()

"." <> extension = Path.extname(path)

content
    |> RawConfigParser.parse(extension)
    |> LayoutParser.parse
    |> AppCompiler.compile
