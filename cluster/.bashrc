# Minimal fallback if zsh does not work.

HISTSIZE=10000

# load spack and module environment; its exported vars must exist before the
# zsh exec in .bash_profile (functions are lost at exec, vars are inherited)
# shellcheck source=/dev/null
[ -f /opt/spack/share/spack/setup-env.sh ] && . /opt/spack/share/spack/setup-env.sh

# fallback aliases
command -v lsd > /dev/null 2>&1 || alias l='ls --almost-all --human-readable -l'
