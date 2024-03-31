vim.g.mapleader = " "

vim.keymap.set("n", "<leader><space>", vim.cmd.nohlsearch)

-- manipulate windows
vim.keymap.set("n", "<leader>w", "<c-w>")
vim.keymap.set("n", "<m-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<m-H>", ":wincmd H<CR>")
vim.keymap.set("n", "<m-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<m-J>", ":wincmd J<CR>")
vim.keymap.set("n", "<m-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<m-K>", ":wincmd K<CR>")
vim.keymap.set("n", "<m-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<m-L>", ":wincmd L<CR>")
vim.keymap.set("n", "<m-w>", ":wincmd w<CR>")
vim.keymap.set("n", "<m-W>", ":wincmd W<CR>")
vim.keymap.set("n", "<m-q>", ":wincmd c<CR>")
vim.keymap.set("n", "<m-Q>", ":wincmd q<CR>")

-- manipulate buffers
vim.keymap.set("n", "<leader>l", vim.cmd.bnext)
vim.keymap.set("n", "<leader>h", vim.cmd.bprevious)
vim.keymap.set("n", "<leader><backspace>", vim.cmd.bdelete)


vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

-- copy/paste to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>d", '"+d')
vim.keymap.set("v", "<leader>d", '"+d')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')


vim.keymap.set("n", "<leader>ss", ":s/")
vim.keymap.set("n", "<leader>S", ":%s/")

