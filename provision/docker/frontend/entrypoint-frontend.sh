#!/usr/bin/env bash
set -eo pipefail
shopt -s nullglob

cd /app

YELLOW="\e[0;93m"
GREEN="\e[0;92m"
BOLD="\e[1m"
RESET="\e[0m"

step()    { echo -e "${YELLOW}${BOLD}===> ${RESET}${*}${RESET}"; }
success() { echo -e "${RESET}${GREEN}${BOLD}${*}${RESET}"; }

step "Environment: ${ENVIRONMENT}"
step "Current dir: $(pwd)"
step "Node version: $(node --version)"
step "Yarn version: $(yarn -v)"

function setup_shell() {
    if [[ ! -f /app/.bashrc ]]; then return 0; fi

    rm -f /home/app/.bashrc

    chown app.app ${HOME_APP}/
    gosu app ln -sf /app/.bashrc ${HOME_APP}/.bashrc

    step "Setup shell $(success [Done])"
}

function check_permissions() {
    (
        find /app /node_modules \
            -not \( -name "frontend"  -prune \) \
            -not \( -name ".git" -prune  \) \
            -not \( -name ".cache" -prune \) \
            -not -user app \
            -exec chown app.app \{\} \; >/dev/null &

        chown app.app /node_modules >/dev/null &
        chown app.app /home/app >/dev/null &

        wait
    ) &

    step "Run permissions check"
}

function setup_frontend_env() {
    if [[ -f /usr/local/bin/yarn ]]; then return 0; fi

    (
        set -x
        mkdir -p /node_modules
        chown app:app -R /node_modules

    )

    step "Node environment $(success [Done])"
}


case "$1" in
    -)
        # Switch to app user
        if [[ ${1} = '-' ]]; then shift; fi
        set -- gosu app bash
    ;;
    --shell)
        (
            setup_shell
            setup_frontend_env
            check_permissions

        )

        # Switch to app user
        if [[ ${1} = '-' ]]; then shift; fi
        set -- gosu app bash
    ;;
esac

step "Running: $@"
exec "$@"
exit 0