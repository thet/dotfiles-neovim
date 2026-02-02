-- https://docs.astral.sh/ty/editors/#neovim
-- https://github.com/mason-org/mason-registry/blob/2026-02-01-net-motion/packages/ty/package.yaml

---- Optional: Only required if you need to update the language server settings
--vim.lsp.config("ty", {
--  settings = {
--    ty = {
--      -- ty language server settings go here
--    },
--  },
--})

-- Required: Enable the language server
vim.lsp.enable("ty")
