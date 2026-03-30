-- URL opener plugin
-- https://github.com/chrishrb/gx.nvim

-- Alternatives: https://github.com/tyru/open-browser.vim

return {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  cmd = { "Browse" },
  init = function()
    vim.g.netrw_nogx = 1 -- disable netrw's gx mapping.
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
  submodules = false, -- not needed, submodules are required only for tests
  opts = {
    open_browser_app = "xdg-open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
    --open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
    handlers = {
      plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
      github = true, -- open github issues
      brewfile = false, -- open Homebrew formulaes and casks
      package_json = true, -- open dependencies from package.json
      search = true, -- search word under cursor if nothing else is found
      go = true, -- open pkg.go.dev from an import statement (uses treesitter)
      jira = false,
    },
    handler_options = {
      search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
      search_engine_options = {
        -- (optional) search engine specific options
        -- the example below is for github, which uses different search syntax
        github = {
          -- 'repo' or 'global'
          search_type = "repo",
        },
        -- you can configure other search engines here
      },
      select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
    },
  },
}
