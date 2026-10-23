-- Compatibility with CodeCompanion's current message metadata. Remove once
-- history's title generator checks message.context and message._meta.tag itself.
local M = {}

function M.setup()
  local generator = require("codecompanion._extensions.history.title_generator")
  if generator._context_filter_installed then
    return
  end

  local function without_context(chat)
    local filtered = vim.tbl_extend("force", {}, chat)
    filtered.messages = vim.tbl_filter(function(message)
      return not message.context and not (message._meta and message._meta.tag)
    end, chat.messages or {})
    return filtered
  end

  local generate = generator.generate
  generator.generate = function(self, chat, callback, is_refresh)
    return generate(self, without_context(chat), callback, is_refresh)
  end

  local count_user_messages = generator._count_user_messages
  generator._count_user_messages = function(self, chat)
    return count_user_messages(self, without_context(chat))
  end

  generator._context_filter_installed = true
end

return M
