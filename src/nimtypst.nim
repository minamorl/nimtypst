# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import std/pegs

let typstGrammar = peg"""
  Typst <- Stmt+
  
  Stmt <- Heading / Paragraph / List / CodeBlock / Table / Math / Symbol / Comment / Text
  
  Heading <- "=" " "? (!"=" .)+ \n
  Paragraph <- (!("=" / "-" / "```" / "$$" / "$" / "#" / "//") .)+ \n
  List <- "-" " " (!"```" .)+ \n
  CodeBlock <- "```" (!"\\n```" .)* "```" \n
  Table <- "|" " "? (!"|\\n" .)+ ("\\n" "|" " "? (!"|\\n" .)+)* \n
  Math <- "$$" (!"$$" .)* "$$"
  Symbol <- "$" (!"$" .)+ "$"
  Comment <- "//" (!"\\n" .)* \n
  Text <- (!("=" / "-" / "```" / "$$" / "$" / "#" / "//" / \n) .)+
"""
# Parse a Typst document
proc parseTypst(input: string): seq[string] =
  return input.findALl(typstGrammar)
  
# Example usage
let typstDoc = """
= Introduction
This is a paragraph.
- List item 1
- List item 2

```nim
echo "Hello, World!"

Another paragraph.
```
"""

let ast = parseTypst(typstDoc)
echo ast

