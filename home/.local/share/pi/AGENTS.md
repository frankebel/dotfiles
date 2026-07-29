# Global Instructions

## KISS

Keep it simple, stupid. Don't over-engineer stuff.

## Markdown

- Break lines at logical locations
  (commas, brackets, sentence ends)
  rather than in the middle of words or arbitrary positions.
  Start a new sentence on a new line.
  Take this file as a reference.
- Sort sections alphabetically.

## Pi Config Location

The pi config directory is given by the `PI_CODING_AGENT_DIR` environment variable
(not `~/.pi/agent`).

## Rendering LaTeX

When the user asks to render, display, or show a LaTeX equation,
first show the LaTeX source in a `math` code block,
then render it inline with `pi_latex_inline`:

```sh
pi_latex_inline '\mathrm{i}\hbar\,\partial_t \,|\psi\rangle = \hat{H}|\psi\rangle'
```

- `pi_latex_inline` renders $\LaTeX$ math via `lualatex` and displays the result inline
  in kitty using the graphics protocol.
  It also saves a PDF to `/tmp/pi_latex_inline_output.pdf`.
- Pass only the math content (no `$...$`/`\(...\)`/`\[...\]` wrappers);
  bare math is wrapped in `\[ ... \]` automatically.
  Top-level environments (`align*`, `gather*`, `equation*`, etc.) are passed through unwrapped.
- Use upright forms for mathematical constants.
- If `pi_latex_inline` is unavailable or the terminal is not kitty,
  fall back to showing the LaTeX source in a code block.

## Style

- Keep responses concise.
- Insert a space between a number and its unit prefix
  (per BIPM's official guideline: "25 M", "3 kg", "5 km",
  not "25M", "3kg", "5km").
