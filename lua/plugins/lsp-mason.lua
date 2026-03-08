return {
  -- https://github.com/mason-org/mason.nvim
  -- https://github.com/mason-org/mason-registry
  -- https://mason-registry.dev/registry/list?search=copilot
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "copilot-language-server",
        "biome",
        "tailwindcss-language-server",

        -- Language servers for your languages
        "ty", -- Python
        "html-lsp", -- HTML
        "css-lsp", -- CSS
        "typescript-language-server", -- TypeScript/JavaScript
        "lua-language-server", -- Lua
        "rust-analyzer", -- Rust
        "gopls", -- Go
        "bash-language-server", -- Bash
        "sqlls", -- SQL

        -- Additional useful language servers
        "json-lsp", -- JSON
        "yaml-language-server", -- YAML
        "dockerfile-language-server", -- Docker
        "taplo", -- TOML
        "marksman", -- Markdown

        -- Linters and formatters
        "prettier", -- Web development formatter
        "stylua", -- Lua formatter
        "shfmt", -- Shell script formatter
        "eslint_d", -- JavaScript/TypeScript linter
        "shellcheck", -- Shell script linter
        "sqlfluff", -- SQL linter/formatter
        "ruff", -- Python formatter and linter
        "rustfmt", -- Rust formatter
        "gofumpt", -- Go formatter
        "golines", -- Go line length formatter
        "goimports", -- Go import organizer
      },
    },
  },

  -- Disable mason-lspconfig since we're not using nvim-lspconfig
  { "mason-org/mason-lspconfig.nvim", enabled = false },
}
