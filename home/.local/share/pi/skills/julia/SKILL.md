---
name: julia
description: >-
  Julia conventions.
  Use whenever reading, writing, or testing Julia code.
---

# Julia

- Run `jetls check --show-severity=hint` from the project root
  on the package entry file (`src/PKG.jl`) and on `test/runtests.jl`.
- Never run `Pkg.develop`, or `Pkg.add` with a path or URL,
  in an environment whose `Project.toml` is tracked:
  they write a `[sources]` block of absolute local paths into it.
  `Pkg.instantiate` and `Pkg.resolve` leave `Project.toml` untouched
  once a `Manifest.toml` exists,
  so reach for those instead.
  Strip a `[sources]` block that appears anyway before staging,
  otherwise the machine's directory layout lands in the repository.
- Do not set up an environment that already resolves.
  Run the build or test command on its own first,
  and instantiate only once it fails on a missing dependency.
  A setup step in a CI workflow is not evidence that one is needed:
  it bootstraps a bare checkout,
  which a working tree is not.

## Docstrings

- Follow the official Julia style guide
  ([Writing Documentation](https://docs.julialang.org/en/v1/manual/documentation/)).
- Use the short-form signature (no type annotations)
  for closely-related bindings
  (e.g. `evaluate_gaussian`/`evaluate_lorentzian`).
- Give a type the `Type <: Super` docstring signature
  and the outer constructor its own docstring (`Type(args)`)
  when it has meaningful behavior (e.g. defaults).

## File Structure

Within each file,
group the definitions in this order,
with functions sorted alphabetically inside each block:

- define the struct with potential inner creator

- outer creators

- methods using the struct

- `Base` functions using the struct

- other modules (e.g. `LinearAlgebra`) using the struct

## Formatting

- Run `runic --check` on every Julia file you edit
  and leave no formatting violations.
- Keep lines under 92 characters.
- When a function definition or call is too wide to fit in 92 characters,
  break after the opening parenthesis
  and end the last argument with a trailing comma.
  Give each argument its own line
  when they do not all fit on one continuation line.

## Naming

- Write epsilon as `ϵ` (U+03F5, `\epsilon`)
  and phi as `ϕ` (U+03D5, `\phi`),
  never as `ε` (U+03B5, `\varepsilon`) or `φ` (U+03C6, `\varphi`):

## Tests

- Prefer hardcoded expected numerical values
  over comparing the function to itself.
