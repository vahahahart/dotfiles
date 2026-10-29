local M = {}
local timer

function M.setup()
  local state_dir = (vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state"))
    .. "/dotfiles-theme"
  local current

  local function refresh()
    local file = io.open(state_dir .. "/current", "r")
    local mode = file and file:read("*l") or "light"
    if file then
      file:close()
    end
    if (mode == "light" or mode == "dark") and mode ~= current then
      require("vscode").load(mode)
      current = mode
    end
  end

  require("vscode").setup({
    transparent = false,
    italic_comments = true,
  })
  refresh()

  if timer then
    timer:stop()
    timer:close()
  end
  timer = assert(vim.uv.new_timer())
  timer:start(2000, 2000, vim.schedule_wrap(refresh))

  local group = vim.api.nvim_create_augroup("dotfiles_theme", { clear = true })
  vim.api.nvim_create_autocmd("FocusGained", {
    group = group,
    callback = refresh,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      timer:stop()
      timer:close()
      timer = nil
    end,
  })
end

return M
