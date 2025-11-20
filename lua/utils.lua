-- lua/utils.lua
local M = {}

local function get_name(name)
  if name and name ~= "" then
    return vim.fs.basename(name)
  end
  return vim.fs.basename(vim.api.nvim_buf_get_name(0))
end

local function get_path(path)
  if path and path ~= "" then
    return path
  end
  return vim.api.nvim_buf_get_name(0)
end

---@param path_or_name? string
---@return boolean
function M.is_secrets_file(path_or_name)
  local fullpath = get_path(path_or_name) or ""
  local name = get_name(path_or_name) or ""

  ---------------------------------------------------------------------------
  -- 1. Directory-based rules: anything under these dirs is considered secret
  ---------------------------------------------------------------------------
  local normalized = fullpath:gsub("\\", "/")

  local secret_dirs = {
    "/%.ssh/", -- ~/.ssh/**
    "/%.gnupg/", -- ~/.gnupg/**
    "/%.config/sops/", -- ~/.config/sops/**
    "/%.kube/", -- ~/.kube/**
  }

  for _, dir_pat in ipairs(secret_dirs) do
    if normalized:match(dir_pat) then
      return true
    end
  end

  ---------------------------------------------------------------------------
  -- 2. Filename-based patterns
  ---------------------------------------------------------------------------
  local patterns = {
    -- dotenv-ish
    "^%.env", -- .env, .env.local, etc.
    "%.env$", -- foo.env
    "%.env%.", -- foo.env.local

    -- vault files
    "[._-]vault%.yml$", -- foo.vault.yml, bar-vault.yml, _vault.yml

    -- encrypted files
    "%.gpg$", -- *.gpg
    "%.pgp$", -- *.pgp

    -- generic "secret" naming
    "^secret$", -- secret
    "^secrets?$", -- secret / secrets
    "secret%.", -- secret.json, secrets.yml
    "%.secret$", -- .secret
  }

  for _, pat in ipairs(patterns) do
    if name:match(pat) then
      return true
    end
  end

  return false
end

return M
