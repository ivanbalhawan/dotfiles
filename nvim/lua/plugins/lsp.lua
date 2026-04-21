return {
    { "williamboman/mason.nvim",           opts = {} },
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "ruff", "pylsp" } } },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
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
            vim.lsp.enable("pylsp")

            vim.lsp.config("ruff", {
                settings = {
                    configurationPreference = "filesystemFirst",
                    lint = { enable = true, preview = true },
                },
            })
            vim.lsp.enable("ruff")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,            opts)
                    vim.keymap.set("n", "gd",         telescope_builtin.lsp_definitions,  opts)
                    vim.keymap.set("n", "gr",         telescope_builtin.lsp_references,   opts)
                    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,         opts)
                    vim.keymap.set("n", "K",          vim.lsp.buf.hover,                  opts)
                    vim.keymap.set("n", "<leader>D",  vim.lsp.buf.type_definition,        opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,                 opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,   opts)
                    vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float,          opts)
                    vim.keymap.set("n", "<leader>q",  vim.diagnostic.setloclist,          opts)
                end,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.name == "ruff" then
                        client.server_capabilities.hoverProvider = false
                    end
                end,
                desc = "LSP: Disable hover capability from Ruff",
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "codeium" },
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        keys = {
            { "<leader>fo", function() require("conform").format({ async = true }) end, desc = "Format file" },
        },
        opts = {
            formatters_by_ft = {
                lua      = { "stylua" },
                python   = { "ruff_organize_imports", "ruff_format" },
                bash     = { "shfmt" },
                shell    = { "shfmt" },
                sh       = { "shfmt" },
                html     = { "prettierd" },
                jsonc    = { "prettierd" },
                json     = { "jq" },
                markdown = { "mdformat" },
            },
        },
    },
    {
        "Exafunction/codeium.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
        config = function()
            require("codeium").setup({})
        end,
    },
}
