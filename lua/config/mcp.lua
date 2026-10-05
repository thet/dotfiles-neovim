local M = {}

-- Keep the shell's fnm selection; GUI launches can fall back to fnm's default.
function M.setup_path()
  local paths = { vim.fn.expand("~/node_modules/.bin") }
  if vim.fn.executable("node") == 0 then
    local node_bin = vim.fn.expand("~/.local/share/fnm/aliases/default/bin")
    if vim.fn.executable(node_bin .. "/node") == 1 then
      table.insert(paths, node_bin)
    end
  end
  for _, path in ipairs(vim.split(vim.env.PATH or "", ":", { plain = true })) do
    if not vim.tbl_contains(paths, path) then
      table.insert(paths, path)
    end
  end
  vim.env.PATH = table.concat(paths, ":")
end

local function name_value_list(values)
  local result = {}
  for _, name in ipairs(vim.fn.sort(vim.tbl_keys(values or {}))) do
    table.insert(result, { name = name, value = values[name] })
  end
  return result
end

-- ACP agents connect to these servers themselves. MCP Hub's Lua-native tools
-- and its per-tool approval settings are not forwarded by this configuration.
function M.acp_servers()
  local manager = require("mcphub.utils.config_manager")
  local paths = manager.get_active_config_files()
  if #paths == 0 then
    paths = { require("mcphub.config").config.config }
  end

  local servers = {}
  for _, path in ipairs(paths) do
    -- Hub events keep this cache current. Reading an adapter must not reload
    -- the cache and notify all MCP Hub subscribers on every resolution.
    local file_config = manager.get_file_config(path)
    assert(file_config, "Cannot read MCP Hub configuration: " .. path)
    servers = vim.tbl_extend("force", servers, file_config.mcpServers)
  end

  local result = {}
  for _, name in ipairs(vim.fn.sort(vim.tbl_keys(servers))) do
    local server = servers[name]
    if not server.disabled then
      if server.command then
        table.insert(result, {
          name = name,
          command = vim.fn.exepath(server.command) ~= "" and vim.fn.exepath(server.command) or server.command,
          args = vim.deepcopy(server.args or {}),
          env = name_value_list(server.env),
        })
      elseif server.url then
        table.insert(result, {
          name = name,
          type = server.type == "sse" and "sse" or "http",
          url = server.url,
          headers = name_value_list(server.headers),
        })
      end
    end
  end
  return result
end

return M
