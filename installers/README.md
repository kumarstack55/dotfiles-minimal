# installers

## McKeeman Form

```
program
    ws0 line ws0

line
    ""
    comment
    command

comment
    "#" any_characters

command
    function
    function ws1 arguments

function
    "copy"
    "copy_win"
    "mkdir_win"

arguments
    argument
    argument ws1 arguments

argument
    string

string
    '"' string_characters '"'

string_characters
    ""
    string_character string_characters

string_character
    any_characters - '"' - '\' - '$'
    escape
    variable

escape
    '"'
    '\'
    '$'

variable
    '${' variable_name '}'

variable_name
    "HOME"
    "PROFILE"

space
    '0020'

ws1
    space ws0

ws0
    ""
    space ws0
```
