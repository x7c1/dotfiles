-- Local overrides on top of kickstart.nvim. Loaded automatically from
-- after/plugin/, so these run after kickstart's own setup and win on
-- conflicts.

-- Indent: 2 spaces, expand tabs.
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Searches stop at the end of the file instead of wrapping back to the top.
vim.o.wrapscan = false

-- Don't keep .swp files alongside edited files.
vim.o.swapfile = false

-- Allow horizontal cursor motion to wrap over line boundaries.
vim.o.whichwrap = 'b,s,h,l,<,>,~,[,]'

-- Use double-Esc to clear search highlight (kickstart binds single Esc as
-- well; this is just an additional, more deliberate trigger).
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- In visual mode, * searches for the selected text.
vim.keymap.set('x', '*', 'y/<C-r>0<CR>', { desc = 'Search visual selection' })

-- Highlight Japanese full-width spaces (zenkaku) so they don't sneak into
-- code unnoticed.
vim.api.nvim_set_hl(0, 'ZenkakuSpace', { ctermbg = 'black', bg = 'black' })
local zenkaku_group = vim.api.nvim_create_augroup('ZenkakuSpace', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinNew' }, {
  group = zenkaku_group,
  callback = function()
    vim.fn.matchadd('ZenkakuSpace', '　')
  end,
})
