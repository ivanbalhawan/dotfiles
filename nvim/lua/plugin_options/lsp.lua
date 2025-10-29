-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "ruff", "pylsp" },
})

-- Formatter setup with conform.nvim
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "ruff_format" }, -- isort first, then Ruff for formatting
		bash = { "shfmt" },
		shell = { "shfmt" },
		sh = { "shfmt" },
		jsonc = { "prettierd" },
		json = { "jq" },
		markdown = { "mdformat" },
	},
})

vim.keymap.set("n", "<leader>fo", function()
	require("conform").format({ async = true })
end, { desc = "Format file" })

local telescope_builtin = require("telescope.builtin")
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("pylsp", {
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
-- vim.lsp.config("pyright", {
-- 	settings = {
-- 		pyright = {
-- 			disableOrganizeImports = true,
-- 		},
-- 		python = {
-- 			analysis = {
-- 				-- Ignore all files for analysis to exclusively use Ruff for linting
-- 				ignore = { "*" },
-- 			},
-- 		},
-- 	},
-- })
-- vim.lsp.enable("pyright")
vim.lsp.enable("pylsp")
vim.lsp.config("ruff", {
	settings = {
		configurationPreference = "filesystemFirst",
		lint = {
			enable = true,
			preview = true,
		},
	},
})
vim.lsp.enable("ruff")

-- LspAttach: runs after LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable omnifunc for completion
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Keymaps for LSP actions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gr", telescope_builtin.lsp_references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})
