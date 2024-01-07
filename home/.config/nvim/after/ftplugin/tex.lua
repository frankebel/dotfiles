-- options
vim.opt_local.colorcolumn = { "80", "100", "120" }

-- Completion
local cmp = require("cmp")
local sources = cmp.get_config().sources
for i = 1, #sources do
  if sources[i].name == "latex_symbols" then
    sources[i].option.strategy = 2
  end
end
cmp.setup.buffer({ sources = sources })
