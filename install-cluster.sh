#!/bin/sh
# Provision ~/.local/bin on a cluster.
# Skips each tool when its pinned version is already installed,
# so re-runs are cheap and a partial failure can be re-run safely.
set -eu

DEST="$HOME/.local/bin"
TMP="${TMPDIR:-/tmp}/cluster-tools"

command -v curl > /dev/null 2>&1 || {
    echo "curl required" >&2
    exit 1
}

mkdir -p "$DEST" "$HOME/.local/opt" "$TMP"

dl() {
    curl -fsSL -o "$TMP/$1" "$2"
}

installed() { # $1 = binary name, $2 = version substring to expect
    "$DEST/$1" --version 2> /dev/null | grep -q -- "$2"
}

# bat
V=0.26.1
if ! installed bat "$V"; then
    echo "bat $V"
    dl bat.tgz "https://github.com/sharkdp/bat/releases/download/v$V/bat-v$V-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/bat.tgz" -C "$TMP"
    mv "$TMP/bat-v$V-x86_64-unknown-linux-musl/bat" "$DEST/bat"
fi

# delta
V=0.19.2
if ! installed delta "$V"; then
    echo "delta $V"
    dl delta.tar.gz "https://github.com/dandavison/delta/releases/download/$V/delta-$V-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/delta.tar.gz" -C "$TMP"
    mv "$TMP/delta-$V-x86_64-unknown-linux-musl/delta" "$DEST/delta"
fi

# fd
V=10.4.2
if ! installed fd "$V"; then
    echo "fd $V"
    dl fd.tar.gz "https://github.com/sharkdp/fd/releases/download/v$V/fd-v$V-x86_64-unknown-linux-gnu.tar.gz"
    tar -xzf "$TMP/fd.tar.gz" -C "$TMP"
    mv "$TMP/fd-v$V-x86_64-unknown-linux-gnu/fd" "$DEST/fd"
fi

# fzf
V=0.74.3
if ! installed fzf "$V"; then
    echo "fzf $V"
    dl fzf.tgz "https://github.com/junegunn/fzf/releases/download/v$V/fzf-$V-linux_amd64.tar.gz"
    tar -xzf "$TMP/fzf.tgz" -C "$DEST" fzf
fi

# jq
V=1.7.1
if ! installed jq "$V"; then
    echo "jq $V"
    dl jq "https://github.com/jqlang/jq/releases/download/jq-$V/jq-linux-amd64"
    chmod +x "$TMP/jq"
    mv "$TMP/jq" "$DEST/jq"
fi

# lsd
V=1.2.0
if ! installed lsd "$V"; then
    echo "lsd $V"
    dl lsd.tgz "https://github.com/lsd-rs/lsd/releases/download/v$V/lsd-v$V-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/lsd.tgz" -C "$TMP"
    mv "$TMP/lsd-v$V-x86_64-unknown-linux-musl/lsd" "$DEST/lsd"
fi

# nvim
V=0.12.4
if ! installed nvim "$V"; then
    echo "nvim $V"
    dl nvim.tgz "https://github.com/neovim/neovim-releases/releases/download/v$V/nvim-linux-x86_64.tar.gz"
    rm -rf "$HOME/.local/opt/nvim" "$TMP/nvim-extract"
    mkdir -p "$TMP/nvim-extract"
    tar -xzf "$TMP/nvim.tgz" -C "$TMP/nvim-extract"
    mv "$TMP/nvim-extract/nvim-linux-x86_64" "$HOME/.local/opt/nvim"
    ln -sf "$HOME/.local/opt/nvim/bin/nvim" "$DEST/nvim"
fi

# ripgrep
V=15.2.0
if ! installed rg "$V"; then
    echo "ripgrep $V"
    dl rg.tar.gz "https://github.com/BurntSushi/ripgrep/releases/download/$V/ripgrep-$V-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/rg.tar.gz" -C "$TMP"
    mv "$TMP/ripgrep-$V-x86_64-unknown-linux-musl/rg" "$DEST/rg"
fi

# ShellCheck
V=0.11.0
if ! installed shellcheck "$V"; then
    echo "shellcheck $V"
    dl shellcheck.tar.xz "https://github.com/koalaman/shellcheck/releases/download/v$V/shellcheck-v$V.linux.x86_64.tar.xz"
    tar -xJf "$TMP/shellcheck.tar.xz" -C "$TMP"
    mv "$TMP/shellcheck-v$V/shellcheck" "$DEST/shellcheck"
fi

# shfmt
V=3.13.1
if ! installed shfmt "$V"; then
    echo "shfmt $V"
    dl shfmt "https://github.com/mvdan/sh/releases/download/v$V/shfmt_v${V}_linux_amd64"
    chmod +x "$TMP/shfmt"
    mv "$TMP/shfmt" "$DEST/shfmt"
fi

# starship
V=1.26.0
if ! installed starship "$V"; then
    echo "starship $V"
    dl starship.tar.gz "https://github.com/starship/starship/releases/download/v$V/starship-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/starship.tar.gz" -C "$TMP"
    mv "$TMP/starship" "$DEST/starship"
fi

# stow
V=2.4.1
if ! installed stow "$V"; then
    echo "stow $V"
    dl stow.tar.gz "https://ftp.gnu.org/gnu/stow/stow-$V.tar.gz"
    tar -xzf "$TMP/stow.tar.gz" -C "$TMP"
    cd "$TMP/stow-$V"
    ./configure --prefix="$HOME/.local"
    make -j"$(nproc)"
    make install
    cd /
fi

# stylua
V=2.5.2
if ! installed stylua "$V"; then
    echo "stylua $V"
    dl stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/v$V/stylua-linux-x86_64-musl.zip"
    unzip -p "$TMP/stylua.zip" stylua > "$TMP/stylua"
    chmod +x "$TMP/stylua"
    mv "$TMP/stylua" "$DEST/stylua"
fi

# tree-sitter: no upstream release links old glibc.
# Pull the conda-forge compat build.
V=0.26.13
if ! installed tree-sitter "$V"; then
    echo "tree-sitter $V"
    dl ts.conda "https://conda.anaconda.org/conda-forge/linux-64/tree-sitter-cli-$V-hc7555a6_0.conda"
    command -v zstd > /dev/null 2>&1 || {
        echo "tree-sitter: need the zstd binary" >&2
        exit 1
    }
    unzip -p "$TMP/ts.conda" 'pkg-*.tar.zst' | zstd -d -c | tar -xOf - bin/tree-sitter > "$TMP/tree-sitter"
    mv "$TMP/tree-sitter" "$DEST/tree-sitter"
    chmod +x "$DEST/tree-sitter"
fi

# typos
V=1.49.0
if ! installed typos "$V"; then
    echo "typos $V"
    dl typos.tar.gz "https://github.com/crate-ci/typos/releases/download/v$V/typos-v$V-x86_64-unknown-linux-musl.tar.gz"
    tar -xzf "$TMP/typos.tar.gz" -C "$TMP"
    mv "$TMP/typos" "$DEST/typos"
fi

# uv (not version-pinned; `uv self update` after)
if [ ! -x "$DEST/uv" ]; then
    echo "uv"
    env UV_INSTALL_DIR="$DEST" UV_UNMANAGED_INSTALL=1 sh -c \
        'curl -LsSf https://astral.sh/uv/install.sh | sh'
fi

# zsh: no static build for old glibc; build ncurses + zsh from source into
# ~/.local (rpath so zsh finds the local ncurses at runtime).
V=5.9.2
if ! installed zsh "$V"; then
    echo "zsh $V"
    command -v cc > /dev/null 2>&1 || {
        echo "zsh: need a C compiler" >&2
        exit 1
    }
    cd "$TMP"
    dl ncurses.tar.gz "https://invisible-island.net/datafiles/release/ncurses.tar.gz"
    tar xzf ncurses.tar.gz
    cd ncurses-*
    ./configure \
        --prefix="$HOME/.local" \
        --with-termlib \
        --without-ada \
        --without-manpages \
        --without-tests \
        CFLAGS="-O2 -fPIC"
    make -j"$(nproc)"
    make install
    cd "$TMP"
    dl "zsh-$V.tar.xz" "https://www.zsh.org/pub/zsh-$V.tar.xz"
    tar xJf "zsh-$V.tar.xz"
    cd "zsh-$V"
    ./configure \
        --prefix="$HOME/.local" \
        CPPFLAGS="-I$HOME/.local/include" \
        LDFLAGS="-L$HOME/.local/lib -Wl,-rpath,$HOME/.local/lib"
    make -j"$(nproc)"
    make install
    cd /
fi

rm -rf "$TMP"
echo "Done. Binaries are in $DEST."
