def create_left_prompt [] {
    let main_color = if (is-admin) { ansi red } else { ansi green }
    let sep_color = if (is-admin) { ansi light_red } else { ansi light_cyan }
    let path_segment = $env.PWD
        | str replace $nu.home-path "~"
        | str replace --all (char path_sep) $"($sep_color)(char path_sep)($main_color)"
    if ($path_segment == "~") { "" } else { $"($main_color)($path_segment)" }
}

def create_colored_indicator [admin: string, non_admin: string] {
    if (is-admin) { $"(ansi light_red)($admin) " } else { $"(ansi light_cyan)($non_admin) " }
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

$env.PROMPT_INDICATOR = {|| create_colored_indicator "#" "$" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| create_colored_indicator "#" "$" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| create_colored_indicator "#" "$" }
$env.PROMPT_MULTILINE_INDICATOR = {|| create_colored_indicator "#:::" "$:::" }

$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append ($env.HOME | path join .local bin)
    | append ($env.XDG_DATA_HOME | path join dotnet .dotnet tools)
    | append ($env.XDG_DATA_HOME | path join cargo bin)
    | append ($env.XDG_DATA_HOME | path join npm bin)
    | append ($env.XDG_DATA_HOME | path join nvim mason bin)
    | uniq
)

$env.WINEPREFIXES = $env.XDG_DATA_HOME | path join wine prefixes
$env.WINEPREFIX_DEV = $env.WINEPREFIXES | path join dev
