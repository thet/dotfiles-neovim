return {
  "neovim/nvim-lspconfig",
  config = function()
    local function buildout_paths(instance)
      local ok, lines = pcall(vim.fn.readfile, instance)
      if not ok then
        return nil, "cannot read " .. instance
      end
      local text = table.concat(lines, "\n")
      local block = text:match("sys%.path%[0:0]%s*=%s*%[(.-)%]")
      if not block then
        return nil, "no sys.path injection block"
      end
      local paths = {}
      for p in block:gmatch([["([^"\n]-)"]]) do
        table.insert(paths, p)
      end
      for p in block:gmatch([['([^'\n]-)']]) do
        table.insert(paths, p)
      end
      -- keep only existing dirs
      local uv = vim.uv or vim.loop
      local out = {}
      for _, p in ipairs(paths) do
        local st = uv.fs_stat(p)
        if st and st.type == "directory" then
          table.insert(out, p)
        end
      end
      return out
    end

    vim.api.nvim_create_user_command("PyrightUseBuildout", function(opts)
      local instance = opts.args ~= "" and opts.args or "bin/instance"
      local paths, err = buildout_paths(instance)
      if not paths then
        vim.notify("PyrightUseBuildout: " .. err, vim.log.levels.ERROR)
        return
      end
      local clients = vim.lsp.get_active_clients({ name = "pyright" })
      if #clients == 0 then
        vim.notify("PyrightUseBuildout: no pyright client running", vim.log.levels.WARN)
        return
      end
      for _, c in ipairs(clients) do
        c.config.settings = c.config.settings or {}
        local s = c.config.settings
        s.python = s.python or {}
        s.python.analysis = s.python.analysis or {}
        s.python.analysis.extraPaths = paths
        c.notify("workspace/didChangeConfiguration", { settings = s })
      end
      vim.notify("Pyright: applied " .. #paths .. " buildout paths from " .. instance, vim.log.levels.INFO)
    end, { nargs = "?", complete = "file", desc = "Use buildout bin/instance paths for Pyright" })
  end,
}
