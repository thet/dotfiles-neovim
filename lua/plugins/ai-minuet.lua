-- Local inline completion (fill-in-the-middle) via Ollama + qwen2.5-coder.
--
-- https://github.com/milanglacier/minuet-ai.nvim
--
-- Prereqs (pull the models once):
--   ollama pull qwen2.5-coder:1.5b
--   ollama pull qwen2.5-coder:3b
--   ollama pull qwen2.5-coder:7b
--
-- Switch the active model at runtime with  :MinuetModel  (or  ,am ).
-- 1.5b = fastest/snappiest ghost text, 7b = smartest but laggier on the 780M iGPU.

local utils = require("utils")

-- The three models we want to flip between.
local minuet_models = {
  "qwen2.5-coder:1.5b",
  "qwen2.5-coder:3b",
  "qwen2.5-coder:7b",
}

return {
  -- 1) The minuet plugin itself, talking to the local Ollama FIM endpoint.
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "InsertEnter",
    opts = {
      provider = "openai_fim_compatible",

      -- One completion per request is much faster on a shared-memory iGPU
      -- than the default 3 (fewer parallel generations).
      n_completions = 1,

      -- Characters of surrounding context sent to the model. Smaller = faster
      -- locally; raise if completions feel context-blind.
      context_window = 2048,

      -- Seconds before an in-flight completion is abandoned. Bump if the 7b
      -- model regularly gets cut off mid-suggestion.
      request_timeout = 3,

      provider_options = {
        openai_fim_compatible = {
          -- Ollama needs no API key; point at any env var that exists so
          -- minuet doesn't error on a "missing key". TERM is always set.
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",

          -- Default startup model; change live via :MinuetModel.
          model = "qwen2.5-coder:3b",

          optional = {
            -- Keep suggestions short for snappy ghost text.
            max_tokens = 128,
            top_p = 0.9,
          },
        },
      },
    },
    config = function(_, opts)
      require("minuet").setup(opts)

      -- Live model switcher across the three qwen2.5-coder sizes.
      vim.api.nvim_create_user_command("MinuetModel", function()
        local current = require("minuet.config").provider_options.openai_fim_compatible.model
        vim.ui.select(minuet_models, {
          prompt = "Minuet (Ollama) model  [now: " .. current .. "]",
        }, function(choice)
          if not choice then
            return
          end
          require("minuet.config").provider_options.openai_fim_compatible.model = choice
          vim.notify("Minuet model → " .. choice, vim.log.levels.INFO)
        end)
      end, { desc = "Switch Minuet Ollama model" })
    end,
    keys = {
      { "<leader>am", "<cmd>MinuetModel<cr>", desc = "Minuet: switch model" },
    },
  },

  -- 2) Register minuet as a blink.cmp source (merged into cmp-blink.lua's opts).
  --    Using the function form so we extend the existing sources rather than
  --    overwrite them.
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or {}
      opts.sources.providers = opts.sources.providers or {}

      -- Show minuet alongside copilot. Remove "copilot" from the default list
      -- in cmp-blink.lua if you want minuet to be the only AI source.
      table.insert(opts.sources.default, 1, "minuet")

      opts.sources.providers.minuet = {
        name = "minuet",
        module = "minuet.blink",
        async = true,
        -- Local generation can be slower than cloud Copilot; give it room.
        timeout_ms = 3000,
        score_offset = 100,

        -- 🔐 Same secret-file guard as copilot (defense in depth, even though
        -- this stays on localhost).
        enabled = function()
          return not utils.is_secrets_file()
        end,
      }
    end,
  },
}
