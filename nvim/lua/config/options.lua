vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 6
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
})

-- Russian ЙЦУКЕН keys act as QWERTY commands; text input stays Russian.
vim.opt.langmap = table.concat({
  "йцукенгшщзфывапролдячсмить;qwertyuiopasdfghjklzxcvbnm",
  "ЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬ;QWERTYUIOPASDFGHJKLZXCVBNM",
  [[ё`,Ё~,х[,Х{,ъ],Ъ},ж\;,Ж:,э',Э\",б\,,Б<,ю.,Ю>]],
}, ",")
vim.opt.langremap = false
