vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", {
  desc = "Save file",
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlighting",
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
  desc = "Show line diagnostics",
})

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
  desc = "List diagnostics for current file",
})

vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist, {
  desc = "List all received diagnostics",
})
