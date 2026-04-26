-- Override blink.cmp options on top of kickstart's defaults.
-- lazy.nvim merges this spec with the one in init.lua by plugin name.
return {
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      -- Add buffer-word completion as a fallback source for files without LSP.
      vim.list_extend(opts.sources.default, { 'buffer' })
    end,
  },
}
