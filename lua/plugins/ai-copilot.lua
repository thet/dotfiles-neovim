return {
  -- https://github.com/zbirenbaum/copilot.lua
  -- https://github.com/zbirenbaum/copilot-cmp
  -- https://github.com/fang2hou/blink-copilot?tab=readme-ov-file#-recipes
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        -- Disable it - blink-copilot will manage sources.
        enabled = false,
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        markdown = true,
        help = true,
        -- disable for secret files.
        sh = function()
          if
            string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env")
            or string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "%.gpg$")
            or string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "%.pgp$")
            or string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^vault.yml$")
          then
            -- disable for .env*, *.gpg, *.pgp, vault.yml files
            return false
          end
          return true
        end,
      },
      -- copilot-lsp integration.
      nes = {
        enabled = true,
        auto_trigger = false,
      },
    },
  },
  -- https://github.com/neovim/nvim-lspconfig
  -- https://github.com/copilotlsp-nvim/copilot-lsp?tab=readme-ov-file#usage
  {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
      vim.lsp.enable("copilot_ls")
    end,
  },
}
