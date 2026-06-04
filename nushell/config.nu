let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}

let dotnet_completer = {|spans|
    dotnet complete (
        $spans | skip 1 | str join " "
    ) | lines
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion
    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }
    match $spans.0 {
        dotnet => $dotnet_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
    show_banner: false
    rm: {
        always_trash: true
    }
    datetime_format: {
        normal: '%d.%m.%y %H:%M'
        table: '%d.%m.%y %H:%M'
    }
    edit_mode: vi
    cursor_shape: {
        vi_insert: line
        vi_normal: block
    }
    display_errors: {
        exit_code: false
        termination_signal: false
    },
    completions: {
        external: {
            enable: true
            completer: $external_completer
        }
    }
}

def create_left_prompt [] {
    tput cup (term size).rows
    let main_color = if (is-admin) { ansi red } else { ansi green }
    let sep_color = if (is-admin) { ansi light_red } else { ansi light_cyan }
    let path_segment = $env.PWD
        | str replace $nu.home-dir "~"
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

alias vim = nvim
alias aw = wiki-search-html
alias aww = wiki-search
alias lg = lazygit
alias ld = lazydocker

def rcloud [name] {
    rclone mount $"($name):/" $"($env.HOME | path join Cloud $name)"
}
alias rcloud = cloud

source ([$nu.default-config-dir, "themes", "vs-code-dark-plus.nu"] | path join)

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    ^yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != $env.PWD and ($cwd | path exists) {
        cd $cwd
    }
    rm -fp $tmp
}
