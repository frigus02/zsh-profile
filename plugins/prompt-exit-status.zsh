#!/bin/zsh

local -A prompt_exit_status_map
prompt_exit_status_map=(
    0 😀 # Success
    1 🤨 # Error
    129 📞 # SIGHUP
    130 🛑 # SIGINT
    131 "(╯°□°）╯︵ ┻━┻" # SIGQUIT
    132 👮 # SIGILL
    133 🐍 # SIGTRAP
    134 💥 # SIGABRT
    135 🚌 # SIGBUS
    136 🧮 # SIGFPE
    137 🔫 # SIGKILL
    138 🥇 # SIGUSR1
    139 💣 # SIGSEGV
    140 🥈 # SIGUSR2
    141 🚿 # SIGPIPE
    142 ⏰ # SIGALRM
    143 💀 # SIGTERM
    147 💤 # SIGSTOP
    148 😴 # SIGTSTP
)

local prompt_exit_status=1
update_prompt_exit_status() {
    prompt_exit_status="$(print -P %?)"
}
add-zsh-hook precmd update_prompt_exit_status

prompt_exit_status() {
    echo "${prompt_exit_status_map[$prompt_exit_status]:-🤷}"
}
