return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "python", "vim", "vimdoc", "query" },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPost",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 6,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 5,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
            })
            vim.cmd([[hi TreesitterContextBottom gui=underline guisp=Grey]])
            vim.cmd([[hi TreesitterContextLineNumberBottom gui=underline guisp=Grey]])
        end,
    },
}
