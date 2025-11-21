return {
  {
    -- https://github.com/zbirenbaum/copilot.lua
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        -- Disable inline ghost text. Blink + NES will handle suggestions.
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
      -- NES integration via copilot-lsp.
      -- This can stay "enabled = true": if copilot_ls is not running,
      -- NES simply has nothing to talk to.
      nes = {
        enabled = true,
        auto_trigger = false,
      },
    },
  },

  {
    -- https://github.com/copilotlsp-nvim/copilot-lsp
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      local utils = require("utils")

      -- debounce for NES UI
      vim.g.copilot_nes_debounce = 500

      ------------------------------------------------------------------
      -- 🔐 Keep secret-file protection: detach Copilot from those bufs
      ------------------------------------------------------------------
      local group = vim.api.nvim_create_augroup("copilot_lsp_secrets", { clear = true })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or not client.name:match("copilot") then
            return
          end

          local bufnr = args.buf
          local path = vim.api.nvim_buf_get_name(bufnr)

          if utils.is_secrets_file(path) then
            -- Detach on the next tick so attach has fully completed
            vim.schedule(function()
              vim.lsp.buf_detach_client(bufnr, client.id)
            end)
          end
        end,
      })

      ------------------------------------------------------------------
      -- ✅ Session toggle: NES OFF by default, ON only when you ask
      ------------------------------------------------------------------

      -- Helper: is any Copilot LSP client running?
      local function has_copilot_client()
        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.name:match("copilot") then
            return true
          end
        end
        return false
      end

      -- :CopilotNesEnable → start copilot_ls for this session
      vim.api.nvim_create_user_command("CopilotNesEnable", function()
        if has_copilot_client() then
          vim.notify("Copilot NES already enabled for this session.", vim.log.levels.INFO)
          return
        end

        -- Starts the Copilot LSP client globally for the session
        vim.lsp.enable("copilot_ls")

        -- Optional: mark the session
        vim.g.copilot_lsp_session_enabled = true

        vim.notify(
          "Copilot NES enabled for this session (non-secret buffers). "
            .. "Re-open buffers if current ones don't attach immediately.",
          vim.log.levels.INFO
        )
      end, { desc = "Enable Copilot NES (via copilot-lsp) for this session" })

      -- :CopilotNesDisable → stop all Copilot LSP clients
      vim.api.nvim_create_user_command("CopilotNesDisable", function()
        local stopped = false

        for _, client in ipairs(vim.lsp.get_clients()) do
          if client.name:match("copilot") then
            vim.lsp.stop_client(client.id)
            stopped = true
          end
        end

        vim.g.copilot_lsp_session_enabled = false

        if stopped then
          vim.notify("Copilot NES disabled for this session.", vim.log.levels.INFO)
        else
          vim.notify("Copilot NES was not running.", vim.log.levels.INFO)
        end
      end, { desc = "Disable Copilot NES (via copilot-lsp) for this session" })
    end,
  },
}
