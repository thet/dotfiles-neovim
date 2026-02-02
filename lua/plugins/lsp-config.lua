if true then
  return {}
end
return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      --servers = {
      --  biome = {

      --    filetypes = { "css", "scss", "less", "javascript", "typescript", "json" },
      --    settings = {
      --      -- https://biomejs.dev/reference/configuration/
      --      biome = {
      --        formatter = {
      --          -- https://biomejs.dev/reference/configuration/#formatteruseeditorconfig
      --          useEditorConfig = true,
      --        },
      --      },
      --    },

      --    -- Get the root dir. Biome doesn't find it by itself. Necessary for respecting .editconfig.
      --    root_dir = function(bufnr, on_dir)
      --      -- 1. Get the full path of the current buffer
      --      local startpath = vim.api.nvim_buf_get_name(bufnr)
      --      if startpath == "" then
      --        -- no path (e.g. [No Name] buffer) → do nothing, skip LSP
      --        return
      --      end

      --      -- 2. Find the project root by looking upwards for common markers
      --      local root = vim.fs.root(startpath, {
      --        ".editorconfig",
      --        "biome.json",
      --        "biome.jsonc",
      --        "package.json",
      --        ".git",
      --      })

      --      -- 3. If we found a root, tell Neovim about it via on_dir
      --      if root then
      --        vim.notify("Biome root: " .. root, vim.log.levels.INFO)
      --        on_dir(root)
      --      else
      --        vim.notify("No Biome root found for: " .. startpath, vim.log.levels.WARN)
      --      end
      --    end,
      --  },
      --},
    },
  },
}
