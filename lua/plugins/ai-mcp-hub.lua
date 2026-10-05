-- https://github.com/ravitemer/mcp-hub
-- https://ravitemer.github.io/mcphub.nvim
--
-- An MCP client for Neovim that seamlessly integrates MCP servers into your
-- editing workflow with an intuitive interface for managing, testing, and
-- using MCP servers with your favorite chat plugins.
--
-- https://github.com/mozilla/firefox-devtools-mcp
-- https://firefox-source-docs.mozilla.org/ai-agent-tools/firefox-devtools-mcp.html
-- https://github.com/ChromeDevTools/chrome-devtools-mcp
--
return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- Use the central installation and provide Node for launches outside a shell.
    init = function()
      require("config.mcp").setup_path()
    end,
    config = function()
      require("mcphub").setup({
        config = vim.fn.expand("~/mcpservers.json"),
        -- Isolate this config from older sessions using servers.json on 37373.
        port = 37374,
        cmd = vim.fn.expand("~/node_modules/.bin/mcp-hub"),
      })
    end,
  },
}
