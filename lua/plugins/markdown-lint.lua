-- https://github.com/mfussenegger/nvim-lint
-- An asynchronous linter plugin for Neovim complementary to the built-in
-- Language Server Protocol support.

-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("$HOME/.markdownlint-cli2.yaml"), "--fix", "$FILENAME" },
        },
      },
    },
  },
}
