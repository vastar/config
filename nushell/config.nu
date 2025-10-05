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

def rcloud [name] {
    rclone mount $"($name):/" $"($env.HOME | path join Cloud $name)"
}
alias rcloud = cloud

source ([$nu.default-config-dir, "themes", "vs-code-dark-plus.nu"] | path join)
