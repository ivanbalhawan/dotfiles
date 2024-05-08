require("mason").setup()
require("mason-lspconfig").setup()
local lsp = require("lspconfig")
local telescope_builtin = require("telescope.builtin")

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.lua_ls.setup({
	capabilities = cmp_capabilities,
})

lsp.pylsp.setup({
	-- single_file_support = false,
	capabilities = cmp_capabilities,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					maxLineLength = 100,
				},
			},
		},
	},
})

require("conform").setup({
	formatters = {
		black = {
			prepend_args = { "--fast" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		bash = { "shfmt" },
		shell = { "shfmt" },
		sh = { "shfmt" },
		jsonc = { "prettierd" },
		json = { "prettierd" },
	},
})
vim.keymap.set("n", "<leader>fo", function()
	require("conform").format({})
end)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {})
	end,
})
