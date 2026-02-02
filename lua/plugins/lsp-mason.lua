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
        "prettier",
        "stylua",
        "shfmt",
        "tailwindcss-language-server",
        "ty",
      },
    },
  },
}
