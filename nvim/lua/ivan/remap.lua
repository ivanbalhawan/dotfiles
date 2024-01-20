vim.g.mapleader = " "
vim.keymap.set("n", "<leader>tt", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader><space>", vim.cmd.nohlsearch)
vim.keymap.set("n", "<leader>ww", vim.cmd.VimwikiIndex)

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

vim.keymap.set("n", "<leader>l", vim.cmd.bnext)
vim.keymap.set("n", "<leader>h", vim.cmd.bprevious)
vim.keymap.set("n", "<leader><backspace>", vim.cmd.bdelete)
-- vim.keymap.set("n", "<leader>j", ":wincmd w<CR>")
-- vim.keymap.set("n", "<leader>k", ":wincmd W<CR>")

vim.keymap.set("n", "<leader>ss", ":s/")
vim.keymap.set("n", "<leader>S", ":%s/")

vim.keymap.set("n", "<leader>w", "<c-w>")
