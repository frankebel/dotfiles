#!/bin/sh
# Provision ~/.local/bin on a cluster.
# Skips each tool when its pinned version is already installed,
# so re-runs are cheap and a partial failure can be re-run safely.
set -eu

DEST="$HOME/.local/bin"
TMP="${TMPDIR:-/tmp}/cluster-tools"

mkdir -p "$DEST" "$HOME/.local/opt" "$TMP"

dl() { # $1 = file name, $2 = URL, $3 = SHA-256
    curl -fsSL -o "$TMP/$1" "$2"
    echo "$3  $TMP/$1" | sha256sum -c --quiet -
}

installed() { # $1 = binary name, $2 = version substring to expect
    "$DEST/$1" --version 2> /dev/null | grep -q -- "$2"
}

# bat
V=0.26.1
S=0dcd8ac79732c0d5b136f11f4ee00e581440e16a44eab5b3105b611bbf2cf191
if ! installed bat "$V"; then
    echo "bat $V"
    dl bat.tgz "https://github.com/sharkdp/bat/releases/download/v$V/bat-v$V-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/bat.tgz" -C "$TMP"
    mv "$TMP/bat-v$V-x86_64-unknown-linux-musl/bat" "$DEST/bat"
fi

# delta
V=0.19.2
S=f1ea01ca7728ce3462debc359f39dfc7cbbc1a63224b71fefabf92042864aa1b
if ! installed delta "$V"; then
    echo "delta $V"
    dl delta.tar.gz "https://github.com/dandavison/delta/releases/download/$V/delta-$V-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/delta.tar.gz" -C "$TMP"
    mv "$TMP/delta-$V-x86_64-unknown-linux-musl/delta" "$DEST/delta"
fi

# fd
V=10.4.2
S=def59805cd14b5651b68990855f426ad087f3b96881296d963910431ba3143c8
if ! installed fd "$V"; then
    echo "fd $V"
    dl fd.tar.gz "https://github.com/sharkdp/fd/releases/download/v$V/fd-v$V-x86_64-unknown-linux-gnu.tar.gz" "$S"
    tar -xzf "$TMP/fd.tar.gz" -C "$TMP"
    mv "$TMP/fd-v$V-x86_64-unknown-linux-gnu/fd" "$DEST/fd"
fi

# fzf
V=0.74.3
S=3501a595e4b5c40a6b047340a0e8f805c46fd4e61ef95ef8a136ba8c61cf6f22
if ! installed fzf "$V"; then
    echo "fzf $V"
    dl fzf.tgz "https://github.com/junegunn/fzf/releases/download/v$V/fzf-$V-linux_amd64.tar.gz" "$S"
    tar -xzf "$TMP/fzf.tgz" -C "$DEST" fzf
fi

# jq
V=1.7.1
S=5942c9b0934e510ee61eb3e30273f1b3fe2590df93933a93d7c58b81d19c8ff5
if ! installed jq "$V"; then
    echo "jq $V"
    dl jq "https://github.com/jqlang/jq/releases/download/jq-$V/jq-linux-amd64" "$S"
    chmod +x "$TMP/jq"
    mv "$TMP/jq" "$DEST/jq"
fi

# juliaup
V=1.22.7
S=d7d4a4249da97fdca5e4b312f4cd0d2ecf2bf52111f3421f8c026ef131ec8df2
if ! installed juliaup "$V"; then
    echo "juliaup $V"
    dl juliaup.tar.gz "https://github.com/JuliaLang/juliaup/releases/download/v$V/juliaup-$V-x86_64-unknown-linux-musl-portable.tar.gz" "$S"
    tar -xzf "$TMP/juliaup.tar.gz" -C "$DEST" ./juliaup ./julia
fi

# lsd
V=1.2.0
S=77849da1210336534258551a581401ba19ae6b8d7b66a2a1feff148ad41e3814
if ! installed lsd "$V"; then
    echo "lsd $V"
    dl lsd.tgz "https://github.com/lsd-rs/lsd/releases/download/v$V/lsd-v$V-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/lsd.tgz" -C "$TMP"
    mv "$TMP/lsd-v$V-x86_64-unknown-linux-musl/lsd" "$DEST/lsd"
fi

# nvim
V=0.12.5
S=9e4a0e9c2aebbcf1eb5f6cdf645b460c9249f517650d0191170f9f152ecfd721
if ! installed nvim "$V"; then
    echo "nvim $V"
    dl nvim.tgz "https://github.com/neovim/neovim-releases/releases/download/v$V/nvim-linux-x86_64.tar.gz" "$S"
    rm -rf "$HOME/.local/opt/nvim" "$TMP/nvim-extract"
    mkdir -p "$TMP/nvim-extract"
    tar -xzf "$TMP/nvim.tgz" -C "$TMP/nvim-extract"
    mv "$TMP/nvim-extract/nvim-linux-x86_64" "$HOME/.local/opt/nvim"
    ln -sf "$HOME/.local/opt/nvim/bin/nvim" "$DEST/nvim"
fi

# ripgrep
V=15.2.0
S=33e15bcf1624b25cdd2a55813a47a2f95dbe126268203e76aa6a585d1e7b149c
if ! installed rg "$V"; then
    echo "ripgrep $V"
    dl rg.tar.gz "https://github.com/BurntSushi/ripgrep/releases/download/$V/ripgrep-$V-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/rg.tar.gz" -C "$TMP"
    mv "$TMP/ripgrep-$V-x86_64-unknown-linux-musl/rg" "$DEST/rg"
fi

# ShellCheck
V=0.11.0
S=8c3be12b05d5c177a04c29e3c78ce89ac86f1595681cab149b65b97c4e227198
if ! installed shellcheck "$V"; then
    echo "shellcheck $V"
    dl shellcheck.tar.xz "https://github.com/koalaman/shellcheck/releases/download/v$V/shellcheck-v$V.linux.x86_64.tar.xz" "$S"
    tar -xJf "$TMP/shellcheck.tar.xz" -C "$TMP"
    mv "$TMP/shellcheck-v$V/shellcheck" "$DEST/shellcheck"
fi

# shfmt
V=3.13.1
S=fb096c5d1ac6beabbdbaa2874d025badb03ee07929f0c9ff67563ce8c75398b1
if ! installed shfmt "$V"; then
    echo "shfmt $V"
    dl shfmt "https://github.com/mvdan/sh/releases/download/v$V/shfmt_v${V}_linux_amd64" "$S"
    chmod +x "$TMP/shfmt"
    mv "$TMP/shfmt" "$DEST/shfmt"
fi

# starship
V=1.26.0
S=b7c232b0e8249d8e55a40beb79c5c43a7d370f3f9408bd215deb0170daeaadf3
if ! installed starship "$V"; then
    echo "starship $V"
    dl starship.tar.gz "https://github.com/starship/starship/releases/download/v$V/starship-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/starship.tar.gz" -C "$TMP"
    mv "$TMP/starship" "$DEST/starship"
fi

# stow
V=2.4.1
S=2a671e75fc207303bfe86a9a7223169c7669df0a8108ebdf1a7fe8cd2b88780b
if ! installed stow "$V"; then
    echo "stow $V"
    dl stow.tar.gz "https://ftp.gnu.org/gnu/stow/stow-$V.tar.gz" "$S"
    tar -xzf "$TMP/stow.tar.gz" -C "$TMP"
    cd "$TMP/stow-$V"
    ./configure --prefix="$HOME/.local"
    make -j"$(nproc)"
    make install
    cd /
fi

# stylua
V=2.5.2
S=ca6f1cf52eaf69e6632b81acef9c197aa24b85eb30d2455a35e7dbe28ae77c72
if ! installed stylua "$V"; then
    echo "stylua $V"
    dl stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/v$V/stylua-linux-x86_64-musl.zip" "$S"
    unzip -p "$TMP/stylua.zip" stylua > "$TMP/stylua"
    chmod +x "$TMP/stylua"
    mv "$TMP/stylua" "$DEST/stylua"
fi

# tree-sitter: no upstream release links old glibc.
# Pull the conda-forge compat build.
V=0.26.13
S=2b901c05f06e10690d21d4355a2375e3d2cd587e1444968aac113f9a9d640603
if ! installed tree-sitter "$V"; then
    echo "tree-sitter $V"
    dl ts.conda "https://conda.anaconda.org/conda-forge/linux-64/tree-sitter-cli-$V-hc7555a6_0.conda" "$S"
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
S=48bd2d58e02ce713b8c0f1aa239e68ee4f7d8c551013135806e6aed3938d9e10
if ! installed typos "$V"; then
    echo "typos $V"
    dl typos.tar.gz "https://github.com/crate-ci/typos/releases/download/v$V/typos-v$V-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/typos.tar.gz" -C "$TMP"
    mv "$TMP/typos" "$DEST/typos"
fi

# uv
V=0.12.21
S=d69d543a55ec9cdf9d3d9f2648b0a161847e3dbddc477e3be6b5813a6d46f639
if ! installed uv "$V"; then
    echo "uv $V"
    dl uv.tar.gz "https://github.com/astral-sh/uv/releases/download/$V/uv-x86_64-unknown-linux-musl.tar.gz" "$S"
    tar -xzf "$TMP/uv.tar.gz" -C "$TMP"
    mv "$TMP/uv-x86_64-unknown-linux-musl/uv" "$TMP/uv-x86_64-unknown-linux-musl/uvx" "$DEST/"
fi

# zsh: no static build for old glibc; build ncurses + zsh from source into
# ~/.local (rpath so zsh finds the local ncurses at runtime).
V=5.9.2
S=36fa734374b44783582cec09bcd67822e2f992c779ec1624ab5596df078d2f81
NCURSES_V=6.6
NCURSES_S=355b4cbbed880b0381a04c46617b7656e362585d52e9cf84a67e2009b749ff11
if ! installed zsh "$V"; then
    echo "zsh $V"
    command -v cc > /dev/null 2>&1 || {
        echo "zsh: need a C compiler" >&2
        exit 1
    }
    cd "$TMP"
    dl ncurses.tar.gz "https://invisible-island.net/archives/ncurses/ncurses-$NCURSES_V.tar.gz" "$NCURSES_S"
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
    dl "zsh-$V.tar.xz" "https://www.zsh.org/pub/zsh-$V.tar.xz" "$S"
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
