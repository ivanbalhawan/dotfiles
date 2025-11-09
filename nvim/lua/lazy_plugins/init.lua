return {
    require("lazy_plugins/iron"),
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufEnter",
    },

    "fneu/breezy",
    {
        "Exafunction/codeium.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({
            })
        end
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    -- {
    --     "nvim-neorg/neorg",
    --     dependencies = { "luarocks.nvim" },
    --     lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    --     version = "*", -- Pin Neorg to the latest stable release
    --     config = {
    --         load = {
    --             ["core.defaults"]  = {},
    --             ["core.concealer"] = {},
    --         },
    --     },
    -- },
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
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
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, },

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
