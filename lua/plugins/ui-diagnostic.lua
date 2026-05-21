-- https://github.com/rachartier/tiny-inline-diagnostic.nvim
return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
  -- Override LazyVim's lspconfig diagnostic defaults so virtual_text stays off
  -- even when lspconfig loads lazily after VeryLazy (e.g. on first BufReadPre).
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = false },
    },
  },
}

-- Alternative config
---- Diagnostics: show sign-column icon on all lines, expand full message below current line only
--vim.diagnostic.config({
--  virtual_text = false,
--  virtual_lines = { current_line = true },
--})
