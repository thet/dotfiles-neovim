if true then
  return {}
end
-- Deactivated
return {
  "neovim/nvim-lspconfig",
  init = function()
    local uv = vim.uv or vim.loop

    local function path_join(a, b)
      if not a or a == "" then
        return b
      end
      if b:sub(1, 1) == "/" then
        return b
      end
      if a:sub(-1) == "/" then
        return a .. b
      end
      return a .. "/" .. b
    end

    local function abspath(p)
      if not p then
        return nil
      end
      if p:sub(1, 1) == "/" then
        return p
      end
      return path_join(vim.loop.cwd(), p)
    end

    local function exists_dir(p)
      local st = uv.fs_stat(p)
      return st and st.type == "directory"
    end

    -- Try to read sys.path injection list from bin/instance
    local function read_instance_paths(instance_file)
      instance_file = instance_file or "bin/instance"
      local ok, lines = pcall(vim.fn.readfile, instance_file)
      if not ok then
        return nil, "cannot read: " .. instance_file
      end

      local text = table.concat(lines, "\n")

      -- Match both of these forms:
      --   sys.path[0:0] = [ '…', "…", r"…", u'…', ... ]
      --   sys.path[0:0]=[
      --        '…',
      --        ...
      --   ]
      local block = text:match("sys%.path%[0:0]%s*=%s*%[(.-)%]")
      if not block then
        return {}, "no sys.path[0:0] block found"
      end

      local out = {}

      -- capture quoted strings with optional r/u prefix
      for s in block:gmatch([=[[ruRU]?%s*"([^"\n]-)"]=]) do
        table.insert(out, s)
      end
      for s in block:gmatch([=[[ruRU]?%s*'([^'\n]-)']=]) do
        table.insert(out, s)
      end

      -- normalize to absolute and keep only existing dirs
      local abs = {}
      for _, p in ipairs(out) do
        local full = abspath(p)
        if exists_dir(full) then
          table.insert(abs, full)
        end
      end
      return abs, nil
    end

    -- Fallback: derive import roots from buildout structure
    local function guess_buildout_paths(root)
      root = root or vim.loop.cwd()
      local results = {}

      local eggs = path_join(root, "eggs")
      if exists_dir(eggs) then
        local dh = uv.fs_scandir(eggs)
        if dh then
          while true do
            local name, typ = uv.fs_scandir_next(dh)
            if not name then
              break
            end
            if typ == "directory" then
              local full = path_join(eggs, name)
              -- Buildout eggs are directories like <pkg>-<ver>.dist-info or .egg; use the dir itself
              table.insert(results, full)
            end
          end
        end
      end

      -- include any develop eggs under src/**/src
      local srcroot = path_join(root, "src")
      if exists_dir(srcroot) then
        local dh = uv.fs_scandir(srcroot)
        if dh then
          while true do
            local name, typ = uv.fs_scandir_next(dh)
            if not name then
              break
            end
            if typ == "directory" then
              local subsrc = path_join(path_join(srcroot, name), "src")
              if exists_dir(subsrc) then
                table.insert(results, subsrc)
              end
            end
          end
        end
      end

      return results
    end

    vim.api.nvim_create_user_command("PyrightUseBuildout", function(opts)
      local instance = opts.args ~= "" and opts.args or "bin/instance"
      local cwd = vim.loop.cwd()
      vim.notify(("[Pyright] CWD: %s"):format(cwd))
      vim.notify(("[Pyright] Reading instance: %s"):format(instance))

      local paths, err = read_instance_paths(instance)
      if err then
        vim.notify("[Pyright] instance parse: " .. err, vim.log.levels.WARN)
      end

      if #paths == 0 then
        vim.notify("[Pyright] No paths from instance; falling back to scanning eggs/src", vim.log.levels.WARN)
        paths = guess_buildout_paths(cwd)
      end

      vim.notify(("[Pyright] candidate paths: %d"):format(#paths))
      -- dump them for inspection
      vim.notify(vim.inspect(paths), vim.log.levels.DEBUG)

      if #paths == 0 then
        vim.notify(
          "[Pyright] Still 0 paths; check that you're in the buildout root, or pass an absolute path to bin/instance",
          vim.log.levels.ERROR
        )
        return
      end

      -- Apply to running pyright clients
      local clients = vim.lsp.get_clients({ name = "pyright" }) -- new API
      if #clients == 0 then
        vim.notify("[Pyright] No pyright client running; open a Python file first", vim.log.levels.WARN)
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

      vim.notify(("[Pyright] applied %d buildout paths from %s"):format(#paths, instance), vim.log.levels.INFO)
    end, {
      nargs = "?",
      complete = "file",
      desc = "Use buildout bin/instance sys.path for Pyright (with eggs/src fallback)",
    })
  end,
}
