# Ponytail Audit

Repo-wide over-engineering audit (ponytail-audit, one-shot).
Scope: complexity only — correctness, security, performance are out of scope.
Ranked biggest cut first.

## Findings

1. `shrink:` `install-cluster.sh` — 8 of the 15 tools are the same shape:
   musl tarball → `mv` single binary out of a top-level dir, guarded by
   `installed <name> <ver>` (bat, delta, fd, lsd, rg, typos, starship).
   Collapse those into a `dl_tar()` helper with one call per tool. The
   genuinely irregular ones stay explicit: jq/shfmt raw binaries, fzf/stylua/
   tree-sitter, uv installer, stow + zsh/ncurses source builds.
   net **-80**. `[install-cluster.sh]` (runs rarely — verify carefully before
   trusting).

2. `delete:` `neomutt.md` — a TODO checklist living in the repo root → GitHub
   issues. Replacement: nothing. net **-21**.

3. `delete:` `home/.config/dunst/test.sh` — one-off font-rendering diagnostic
   committed to dotfiles → nothing. net **-12**.

4. `delete:` `README.md:112` links `home/.config/nvim/lazy-lock.json`, which
   does not exist (real file `nvim-pack-lock.json`). nvim/README.md has it
   right. net ~0.

5. `yagni:` `.editorconfig` — the `[[bash]]`, `[[shell]]`, `[[zsh]]` sections
   match no file in the repo (editorconfig matches the file's basename; there
   is no file named `bash`/`shell`/`zsh` — the real ones are `alias`,
   `environment`, `.bashrc`...). The shfmt-style rules apply to nothing.
   Either fix the section names or drop the block. net -9.

## Checked, lean already

- `python/startup.py` — verbatim stdlib readline recipe; fine.
- Duplicate `home/.julia/environments/v1.12|v1.13/Project.toml` — deliberate,
  one per Julia release install.sh provisions.
- `mocha.lua`/`mocha.conf` + bat/btop/kitty/neomutt/qt6ct theme copies —
  theme duplication is inherent to per-app config.
- `hypr/helper.lua`, cluster bootstrap chain, `install.sh`, `huelight`,
  `backup_encrypted` — each earns its lines.

`net: -120 lines possible` (clear -21, -12, -9 plus the -80 install-cluster
refactor).

Biggest bang for lowest risk: the drop-ins (done, commit `217147e`).
Everything else is small or (in #1's case) a provisioning script that runs
twice a year.
