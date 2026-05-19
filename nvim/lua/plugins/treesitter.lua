return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "main",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "c", "lua", "python", "vim", "vimdoc", "query" },
                auto_install = true,
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
