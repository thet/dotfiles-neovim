-- NOTE:
-- Chats stored in:
-- /home/thet/.local/share/nvim/codecompanion-history
-- If you loose your current, thoughtfully crafted chat - e.g. by pressing
-- <ctrl><c> - there you might have some luck.

-- https://github.com/olimorris/codecompanion.nvim
-- https://codecompanion.olimorris.dev/
-- https://codecompanion.olimorris.dev/installation
-- https://codecompanion.olimorris.dev/getting-started
-- https://codecompanion.olimorris.dev/usage/introduction
-- https://codecompanion.olimorris.dev/usage/chat-buffer/
-- https://codecompanion.olimorris.dev/configuration/adapters

-- https://codecompanion.olimorris.dev/usage/chat-buffer/slash-commands#mcp
-- https://codecompanion.olimorris.dev/usage/chat-buffer/agents-tools#mcp

-- https://github.com/mozilla/firefox-devtools-mcp
-- https://github.com/ChromeDevTools/chrome-devtools-mcp

-- https://github.com/ravitemer/codecompanion-history.nvim

-- https://www.chrislockard.net/posts/lmstudio-neovim-codecompanion/

-- ollama
-- https://hrmj.hashnode.dev/a-basic-neovim-local-llm-setup

-- https://blog.olimorris.com/
-- https://www.reddit.com/r/neovim/comments/1n1txun/support_for_agent_client_protocol_in/

-- https://github.com/ravitemer/mcphub.nvim
-- https://ravitemer.github.io/mcphub.nvim/
-- An MCP client for Neovim that seamlessly integrates MCP servers into your
-- editing workflow with an intuitive interface for managing, testing, and
-- using MCP servers with your favorite chat plugins.

-- https://github.com/hakonharnes/img-clip.nvim
-- Embed images into any markup language, like LaTeX, Markdown or Typst

-- https://github.com/nvim-lua/plenary.nvim
-- plenary: full; complete; entire; absolute; unqualified. All the lua
-- functions I don't want to write twice.

-- Other AI plugins:
-- https://github.com/yetone/avante.nvim
-- https://github.com/coder/claudecode.nvim
-- https://github.com/Exafunction/windsurf.nvim
-- https://github.com/folke/sidekick.nvim
-- https://github.com/huggingface/llm-ls
-- https://github.com/huggingface/llm.nvim
-- https://github.com/github/copilot.vim
-- https://github.com/codota/tabnine-nvim
-- https://github.com/tzachar/cmp-tabnine
-- https://github.com/huynle/ogpt.nvim
-- https://github.com/ollama/ollama
-- https://github.com/gsuuon/model.nvim

local spinner = {
  completed = "󰗡 Completed",
  error = " Error",
  cancelled = "󰜺 Cancelled",
}

local default_adapter = {
  name = "codex",
  model = "gpt-5.6-luna",
  --model = "gpt-5.6-sol",
  --model = "gpt-5.6-terra",
  --model = "gpt-5.6-luna",
  --model = "gpt-5.5",
  --name = "copilot",
  --model = "gpt-5.4",
  --model = "gpt-5.3-codex",
  --model = "gpt-4.1",
  --model = "claude-opus-4.8",
  --model = "claude-opus-4.7",
  --model = "claude-opus-4.6",
  --model = "claude-sonnet-4.6",
  --model = "claude-sonnet-5",
}

---Format the adapter name and model for display with the spinner
---@param adapter CodeCompanion.Adapter
---@return string
local function format_adapter(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

---Setup the spinner for CodeCompanion
---@return nil
local function codecompanion_spinner()
  local ok, progress = pcall(require, "fidget.progress")
  if not ok then
    return
  end

  spinner.handles = {}

  local group = vim.api.nvim_create_augroup("dotfiles.codecompanion.spinner", {})

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(args)
      local handle = progress.handle.create({
        title = "",
        message = "  Sending...",
        lsp_client = {
          name = format_adapter(args.data.adapter),
        },
      })
      spinner.handles[args.data.id] = handle
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(args)
      local handle = spinner.handles[args.data.id]
      spinner.handles[args.data.id] = nil
      if handle then
        if args.data.status == "success" then
          handle.message = spinner.completed
        elseif args.data.status == "error" then
          handle.message = spinner.error
        else
          handle.message = spinner.cancelled
        end
        handle:finish()
      end
    end,
  })
end

codecompanion_spinner()

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
      "ravitemer/mcphub.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
      "j-hui/fidget.nvim",
    },
    opts = {
      adapters = {
        http = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                OPENAI_API_KEY = "OPENAI_API_KEY", -- References $OPENAI_API_KEY from environment
              },
              handlers = {
                auth = function()
                  return true
                end,
              },
            })
          end,
          -- Local Codestral 22B via Ollama (http://localhost:11434).
          --   ollama pull codestral:22b
          --   :CodeCompanionChat adapter=codestral
          -- Heavy on a shared-memory iGPU: expect a few tokens/sec. Fine for
          -- chat where you wait; do NOT use it for inline completion.
          codestral = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "codestral",
              schema = {
                model = { default = "codestral:22b" },
                -- Keep context modest on the 780M (shared RAM bandwidth).
                -- Codestral supports up to 32k; raise if you have headroom.
                num_ctx = { default = 8192 },
              },
            })
          end,
          -- Local Gemma 12B via Ollama (http://localhost:11434).
          --   ollama pull gemma4:12b
          --   :CodeCompanionChat adapter=gemma4
          -- Same iGPU caveats as codestral: chat-only, not inline completion.
          gemma4 = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "gemma4",
              schema = {
                model = { default = "gemma4:12b" },
                num_ctx = { default = 8192 },
              },
            })
          end,
        },
        acp = {
          -- Claude Code (Uses `claude` CLI)
          claude_code = function()
            local adapter = require("codecompanion.adapters").extend("claude_code")

            -- Use Claude Code's normal ~/.claude/.credentials.json login.
            -- Assign after extend(), because env = {} inside extend() is deep-merged.
            adapter.env = {}

            return adapter
          end,
          -- Codex with ACP support (Uses `codex-acp`)
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              env = {
                OPENAI_API_KEY = "CODEX_API_KEY", -- References $OPENAI_API_KEY from environment
                -- Using Gnome Keyring secrets storage
                --OPENAI_API_KEY = "cmd:secret-tool lookup service openai key api_key",
              },
              handlers = {
                auth = function()
                  return true
                end,
              },
              defaults = {
                --mcpServers = "inherit_from_config",
                mcpServers = {
                  {
                    name = "chrome_devtools",
                    command = "npx",
                    args = {
                      "-y",
                      "chrome-devtools-mcp@latest",
                      "--executablePath=/usr/bin/chromium",
                      "--headless", -- Allow to run w/out X-Server
                      "--isolated", -- Allow to run multiple browser instances
                    },
                    env = {},
                  },
                },
              },
            })
          end,
          -- Copilot with ACP support (Uses `copilot --acp`)
          copilot_acp = function()
            return require("codecompanion.adapters").extend("copilot_acp", {
              env = {},
              handlers = {
                auth = function()
                  return true
                end,
              },
            })
          end,
          -- Gemini CLI with ACP support (Uses `gemini --acp`)
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              env = {},
              handlers = {
                auth = function()
                  return true
                end,
              },
            })
          end,
        },
      },

      mcp = {
        servers = {
          firefox_devtools = {
            cmd = { "npx", "-y", "firefox-devtools-mcp@latest" },
          },
          chrome_devtools = {
            cmd = {
              "npx",
              "-y",
              "chrome-devtools-mcp@latest",
              "--executablePath=/usr/bin/chromium",
              "--headless", -- Allow to run w/out X-Server
              "--isolated", -- Allow to run multiple browser instances
            },
          },
        },
        opts = {
          acp_enabled = true, -- Enable MCP servers with ACP adapters
        },
      },

      interactions = {
        chat = {
          adapter = default_adapter,
          roles = {
            user = "thet",
          },
          keymaps = {
            send = {
              modes = {
                i = { "<C-CR>", "<C-s>" },
              },
            },
            completion = {
              modes = {
                i = "<C-x>",
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  i = "<C-b>",
                },
              },
              opts = {
                provider = "snacks",
              },
            },
            ["fetch"] = {
              keymaps = {
                modes = {
                  i = "<C-f>",
                },
              },
            },
            ["file"] = {
              opts = {
                provider = "snacks",
              },
            },
            ["help"] = {
              opts = {
                provider = "snacks",
                max_lines = 1000,
              },
            },
            ["image"] = {
              opts = {
                dirs = { "~/Documents/Screenshots" },
              },
            },
          },
        },
        inline = {
          adapter = default_adapter,
        },
        --background = {
        --  chat = {
        --    callbacks = {
        --      ["on_ready"] = {
        --        actions = {
        --          {
        --            path = "interactions.background.builtin.chat_make_title",
        --            adapter = { name = "copilot" },
        --          },
        --        },
        --        -- Enable "on_ready" callback which contains the title generation action
        --        enabled = true,
        --      },
        --    },
        --    opts = {
        --      -- Enable background interactions generally
        --      enabled = true,
        --    },
        --  },
        --},
      },
      keymaps = {
        chat = {
          -- Disable the default 'gx' mapping for clearing chat
          -- We want to use 'gx' for opening URLs instead
          clear = {
            modes = {
              n = "", -- Empty string disables the mapping
            },
          },
        },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          -- show_references = true,
          -- show_header_separator = false,
          -- show_settings = true,
          show_reasoning = true,
          fold_context = true,
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },

            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              -- NOTE: Only use non-ACP, REST API based chat adapters!
              adapter = "codestral",
              --adapter = "gemma4",
              --adapter = "copilot",
              --model = "gpt-4o-mini", -- pin model; default "gpt-5.4-mini" is unsupported
              --adapter = "openai",
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
              format_title = function(original_title)
                -- this can be a custom function that applies some custom
                -- formatting to the title.
                return original_title
              end,
            },

            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,

            -- Summary system
            summary = {
              -- Keymap to generate summary for current chat (default: "gcs")
              create_summary_keymap = "gcs",
              -- Keymap to browse summaries (default: "gbs")
              browse_summaries_keymap = "gbs",

              generation_opts = {
                adapter = nil, -- defaults to current chat adapter
                model = nil, -- defaults to current chat model
                context_size = 90000, -- max tokens that the model supports
                include_references = true, -- include slash command content
                include_tool_outputs = true, -- include tool execution results
                system_prompt = nil, -- custom system prompt (string or function)
                format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
              },
            },

            -- Memory system (requires VectorCode CLI)
            memory = {
              -- Automatically index summaries when they are generated
              auto_create_memories_on_summary_generation = true,
              -- Path to the VectorCode executable
              vectorcode_exe = "vectorcode",
              -- Tool configuration
              tool_opts = {
                -- Default number of memories to retrieve
                default_num = 10,
              },
              -- Enable notifications for indexing progress
              notify = true,
              -- Index all existing memories on startup
              -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
              index_on_startup = false,
            },
          },
        },
        spinner = {},
      },
    },
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
    end,
  },
}
