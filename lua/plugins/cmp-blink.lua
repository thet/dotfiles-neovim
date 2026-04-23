local utils = require("utils")

return {
  -- https://github.com/Saghen/blink.cmp
  -- https://cmp.saghen.dev/installation
  -- https://cmp.saghen.dev/configuration/general
  -- https://cmp.saghen.dev/configuration/appearance
  -- https://cmp.saghen.dev/configuration/completion
  -- https://cmp.saghen.dev/configuration/fuzzy
  -- https://cmp.saghen.dev/configuration/sources
  -- https://cmp.saghen.dev/configuration/snippets
  -- https://cmp.saghen.dev/configuration/reference

  -- Alternative:
  --    https://github.com/hrsh7th/nvim-cmp
  {
    "saghen/blink.cmp",

    dependencies = {
      "fang2hou/blink-copilot",
    },

    opts = {
      -- Only show the documentation popup automatically.
      completion = {
        documentation = {
          auto_show = true,
        },

        -- Don't select by default, auto insert on selection
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },

      -- The following providers will be merged with the default onces.
      -- default = { "lsp", "path", "snippets", "buffer" },
      sources = {
        default = {
          "path",
          "copilot",
          "lsp",
          "snippets",
          "buffer",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,

            -- 🔐 Disable copilot for secret files.
            enabled = function()
              return not utils.is_secrets_file()
            end,
          },
        },
      },

      keymap = {
        -- start from Blink's default mappings (C-y to accept, arrows to move, etc.)
        preset = "default",

        -- -- Tab / S-Tab to move through the completion list
        -- ["<Tab>"] = { "select_next", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "fallback" },

        -- Enter: accept if a completion is selected, otherwise behave like normal <CR>
        ["<CR>"] = { "accept", "fallback" },

        -- Show completion, documentation, or hide documentation
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
    },
  },

  -- https://github.com/fang2hou/blink-copilot
  {
    "fang2hou/blink-copilot",
  },
}
