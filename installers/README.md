# installers

## TODO

- add run_bash
- add test_not_found

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
    "copy_crlf_win"
    "copy_linux"
    "copy_win"
    "debug_var"
    "join_path"
    "mkdir"
    "mkdir_linux"
    "mkdir_win"
    "set"
    "set_linux"
    "set_win"

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
    uppercase_characters_or_lowercase_characters_or_underscores

space
    '0020'

ws1
    space ws0

ws0
    ""
    space ws0
```
