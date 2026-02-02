if true then
  return {}
end
-- Deactivated
-- Force pyright to use the nvim start directory as root_dir
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        root_markers = { "pyright-root.txt" },
        --root_markers: { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" }
        -- -- ALWAYS use the cwd where you started nvim
        -- root_dir = function(_)
        --   -- use vim.loop.cwd(), not util.root_pattern, to force start-dir
        --   local cwd = vim.loop.cwd()
        --   vim.notify("[Pyright root_dir] Using: " .. cwd)
        --   return cwd
        -- end,
      },
    },
  },
}
