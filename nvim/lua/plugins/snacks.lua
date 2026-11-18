local function project_root()
  local cwd = vim.fn.getcwd()
  local filename = vim.api.nvim_buf_get_name(0)
  return vim.fs.root(filename ~= "" and filename or cwd, { ".git" })
    or vim.fs.root(cwd, { ".git" })
    or cwd
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,

  opts = {
    picker = {
      enabled = true,
      sources = {
        files = { cmd = "rg", hidden = true, exclude = { ".git" } },
        grep = { hidden = true, exclude = { ".git" } },
        explorer = { hidden = true, exclude = { ".git" } },
      },
    },
    explorer = { enabled = true },
  },

  keys = {
    {
      "<leader>ff",
      function()
        Snacks.picker.files({ cwd = project_root() })
      end,
      desc = "Find project files",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.grep({ cwd = project_root() })
      end,
      desc = "Search project text",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find open buffers",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ cwd = project_root(), filter = { cwd = true } })
      end,
      desc = "Find recent project files",
    },
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = project_root() })
      end,
      desc = "Toggle project explorer",
    },
  },
}
