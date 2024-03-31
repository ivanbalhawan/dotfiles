local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		layout_strategy = "flex",
		mappings = {
			i = {
				["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<c-h>"] = "preview_scrolling_left",
				["<c-j>"] = "preview_scrolling_down",
				["<c-k>"] = "preview_scrolling_up",
				["<c-l>"] = "preview_scrolling_right",
				["<m-h>"] = "results_scrolling_left",
				["<m-j>"] = "results_scrolling_down",
				["<m-k>"] = "results_scrolling_up",
				["<m-l>"] = "results_scrolling_right",
				["<c-i>"] = "which_key",
			},
			n = {
				["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<c-i>"] = "which_key",
				["<c-h>"] = "preview_scrolling_left",
				["<c-j>"] = "preview_scrolling_down",
				["<c-k>"] = "preview_scrolling_up",
				["<c-l>"] = "preview_scrolling_right",
				["<m-h>"] = "results_scrolling_left",
				["<m-j>"] = "results_scrolling_down",
				["<m-k>"] = "results_scrolling_up",
				["<m-l>"] = "results_scrolling_right",

			},
		},
	},
})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fp", builtin.registers, {})
vim.keymap.set("n", "<leader>fv", builtin.treesitter, {})
vim.keymap.set("n", "<leader>fr", builtin.commands, {})
vim.keymap.set("n", "<leader>ft", builtin.filetypes, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>fM", builtin.keymaps, {})

-- vim.keymap.set('n', '<leader>fs', function()
-- builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
