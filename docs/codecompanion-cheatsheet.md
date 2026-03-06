# CodeCompanion AI Cheatsheet

## Opening a Chat

| Command                                | What it does                                      |
| -------------------------------------- | ------------------------------------------------- |
| `:CodeCompanionChat`                   | Open chat with the default adapter (Copilot)      |
| `:CodeCompanionChat Toggle`            | Toggle last chat buffer open/closed                |
| `:CodeCompanionChat adapter=claude_code` | Open chat using Claude Code via ACP              |
| `:CodeCompanionActions`                | Open the action palette                            |


## Chat Buffer Keymaps

| Key            | Mode   | What it does                                    |
| -------------- | ------ | ----------------------------------------------- |
| `<C-CR>` / `<C-s>` | Insert | Send message                               |
| `<C-x>`        | Insert | Trigger completion                             |
| `<C-b>`        | Insert | Insert `/buffer` (pick open buffers)           |
| `<C-f>`        | Insert | Insert `/fetch` (fetch a URL)                  |
| `[[` / `]]`    | Normal | Jump between responses                         |
| `{` / `}`      | Normal | Cycle between chat buffers                     |
| `gy`           | Normal | Yank the nearest code block                    |
| `gh`           | Normal | Browse chat history                            |
| `sc`           | Normal | Save current chat manually                     |
| `gcs`          | Normal | Generate summary for current chat              |
| `gbs`          | Normal | Browse summaries                               |


## Providing Context (Slash Commands)

Type these in the chat buffer in insert mode. No more copy-pasting!

| Slash command  | What it does                                                 |
| -------------- | ------------------------------------------------------------ |
| `/file`        | Pick file(s) from your project (`Tab` = multi, `Enter` = confirm) |
| `/buffer`      | Add open Neovim buffers (auto-watched by default)            |
| `/symbols`     | Add Tree-sitter symbol outlines (token-efficient)            |
| `/fetch`       | Pull a URL's content into the chat                           |
| `/workspace`   | Share curated file groups (from `codecompanion-workspace.json`) |
| `/help`        | Add vim help file content                                    |
| `/image`       | Add images (from `~/Documents/Screenshots` or URLs)          |
| `/compact`     | Clear history but keep a summary (saves tokens)              |
| `/now`         | Insert current datetime                                      |

### Workspace context for recurring projects

Create a `codecompanion-workspace.json` at the project root:

```json
{
  "groups": [
    {
      "name": "Core",
      "description": "Main entry points and configuration",
      "files": ["src/index.ts", "src/config.ts"]
    },
    {
      "name": "Auth Module",
      "description": "Authentication and authorization",
      "files": ["src/auth/**/*.ts"],
      "symbols": true
    }
  ]
}
```

Then use `/workspace` in the chat to share a group.


## Built-in `@{agent}` Mode (Copilot Adapter)

Works immediately with the default Copilot adapter. No extra setup needed.
Prefix your message with `@{agent}` to give the LLM access to all built-in tools:

```
@{agent} Refactor the auth module to use JWT tokens
```

### Available tools in `@{agent}`

| Tool                    | What it does                                     |
| ----------------------- | ------------------------------------------------ |
| `read_file`             | Read file contents from the working directory    |
| `create_file`           | Create a new file (requires approval)            |
| `delete_file`           | Delete a file (requires approval)                |
| `insert_edit_into_file` | Edit specific parts of a file                    |
| `run_command`           | Execute shell commands (requires approval)       |
| `file_search`           | Search for files by glob pattern                 |
| `grep_search`           | Search text in files (requires ripgrep)          |
| `get_diagnostics`       | Get LSP diagnostics for a file                   |
| `get_changed_files`     | Get git diffs of changed files                   |
| `ask_questions`         | LLM asks clarifying questions before proceeding  |

### Using individual tools

You can also reference tools individually instead of the full agent group:

```
Use @{files} to scaffold out a Python package structure
```

```
Use @{run_command} to run pytest and tell me what's failing
```

```
Can you check @{get_diagnostics} for any issues in the current file?
```


## Claude Code via ACP (Full Agentic Power)

Uses Claude Code as the AI backend through the Copilot API proxy.
This gives you the same capabilities as the `claude` terminal CLI, but inside
CodeCompanion's chat buffer with history support.

### Prerequisites

```
~/.claude/settings.json      # Points Claude Code at the copilot-api proxy
~/node_modules/.bin/copilot-api         # Proxy (pnpm add copilot-api)
~/node_modules/.bin/claude-agent-acp    # ACP bridge (pnpm add @zed-industries/claude-agent-acp)
```

### Usage

**Step 1** — Start the proxy in a terminal (keep it running):

```bash
copilot-api start
```

First time: authenticates with GitHub via device code flow.

**Step 2** — Open a Claude Code chat in Neovim:

```vim
:CodeCompanionChat adapter=claude_code
```

### ACP-specific slash commands

These are only available in ACP adapter chats:

| Slash command  | What it does                                         |
| -------------- | ---------------------------------------------------- |
| `/command`     | Switch between adapter command variants              |
| `/mode`        | Switch agent operating mode                          |

### Switching models

Edit `~/.claude/settings.json` and change `ANTHROPIC_MODEL`:

```json
"ANTHROPIC_MODEL": "claude-sonnet-4-6"
"ANTHROPIC_MODEL": "claude-opus-4-6"
```

### Config reference

`~/.claude/settings.json`:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "http://localhost:4141",
    "ANTHROPIC_AUTH_TOKEN": "sk-dummy",
    "ANTHROPIC_MODEL": "claude-sonnet-4-6",
    "DISABLE_NON_ESSENTIAL_MODEL_CALLS": "1",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

Neovim adapter config (`lua/plugins/ai-codecompanion.lua`):

```lua
claude_code = function()
  return require("codecompanion.adapters").extend("claude_code", {
    env = {},
    handlers = {
      auth = function(self)
        return true -- Auth via copilot-api proxy
      end,
    },
  })
end,
```


## Quick Reference

| I want to...                        | Do this                                           |
| ----------------------------------- | ------------------------------------------------- |
| Quick chat with Copilot             | `:CodeCompanionChat`                              |
| Agentic coding with built-in tools  | `@{agent}` in the chat buffer                     |
| Full Claude Code agentic session    | `:CodeCompanionChat adapter=claude_code`          |
| Add files as context                | `/file` in the chat buffer                        |
| Add current buffer as context       | `/buffer` or `<C-b>` in the chat buffer           |
| Toggle chat open/closed             | `:CodeCompanionChat Toggle`                       |
| Browse past chats                   | `gh` in the chat buffer                           |
