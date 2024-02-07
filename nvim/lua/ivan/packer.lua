-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
   -- Packer can manage itself
   --

    -- Neorg
    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers",
        requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    }
    -- Highlight TODO
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

    use 'wbthomason/packer.nvim'

    use 'Mofiqul/adwaita.nvim'

    use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use ({ 'shaunsingh/nord.nvim', as = 'nord', })

    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    })

    use ('mbbill/undotree')

    use ('tpope/vim-fugitive')

    use { "rcarriga/nvim-notify" }

    use {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
    }

    -- use ({'ms-jpq/coq_nvim', branch='coq'})
    -- use ({'ms-jpq/coq.artifacts', branch='artifacts'})
    -- use ({'ms-jpq/coq.thirdparty', branch='3p'})

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }

    -- use 'vimwiki/vimwiki'

    use 'lervag/vimtex'

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }


end)
