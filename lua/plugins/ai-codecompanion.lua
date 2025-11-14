-- https://github.com/olimorris/codecompanion.nvim
-- https://codecompanion.olimorris.dev/
-- https://codecompanion.olimorris.dev/installation
-- https://codecompanion.olimorris.dev/getting-started
-- https://codecompanion.olimorris.dev/usage/introduction
-- https://codecompanion.olimorris.dev/usage/chat-buffer/
-- https://codecompanion.olimorris.dev/configuration/adapters

-- https://www.chrislockard.net/posts/lmstudio-neovim-codecompanion/

-- https://blog.olimorris.com/

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

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    opts = {},
  },
}
