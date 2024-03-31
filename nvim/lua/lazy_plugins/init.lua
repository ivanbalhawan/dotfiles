return {
    "tpope/vim-fugitive",
    {
        "akinsho/bufferline.nvim",
        dependencies = {
	    "nvim-tree/nvim-web-devicons",
	    "shaunsingh/nord.nvim",
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
    },
    {
        "shaunsingh/nord.nvim",
        name = "nord",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {"nvim-lua/plenary.nvim"},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {"nvim-tree/nvim-web-devicons"},
    },
    {
        "numToStr/Comment.nvim",
         config = function()
                require("Comment").setup()
            end
    },
    -- LSP, Completion, Linter, Formatter
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "mfussenegger/nvim-lint",
    {
        'stevearc/conform.nvim',
        opts = {},
    },
}
