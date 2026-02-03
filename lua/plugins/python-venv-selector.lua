if true then
  return {}
end

-- https://github.com/linux-cultist/venv-selector.nvim
return {
  "linux-cultist/venv-selector.nvim",
  opts = { name = { ".venv", "venv", ".py3", "py3", ".py2", "py2" }, auto_refresh = true },
}
