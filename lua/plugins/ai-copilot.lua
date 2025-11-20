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
        -- 🔐 Disable copilot for secret files, enable for the rest.
        ["*"] = function()
          local utils = require("utils")
          return not utils.is_secrets_file()
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

      local utils = require("utils")

      -- 🔐 Disable copilot for secret files via an autocommand.
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("copilot_lsp_secrets", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local path = vim.api.nvim_buf_get_name(bufnr)

          if utils.is_secrets_file(path) then
            -- detach any Copilot-related LSP clients from this buffer
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
              if client.name == "copilot" or client.name == "copilot_ls" then
                vim.lsp.buf_detach_client(bufnr, client.id)
              end
            end
          end
        end,
      })
    end,
  },
}
