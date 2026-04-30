return {
    { "tpope/vim-fugitive", cmd = { "Git", "G" } },

    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        opts = {
            ignore = "^$",
            toggler = { line = "<leader>cc", block = "<leader>bc" },
            opleader = { line = "<leader>cc", block = "<leader>bc" },
        },
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ft", "<cmd>TodoTelescope<cr>",                                     desc = "Todo (Telescope)" },
            { "]t",         function() require("todo-comments").jump_next() end,           desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end,           desc = "Prev todo comment" },
        },
        config = function()
            require("todo-comments").setup({
                signs = true,
                sign_priority = 8,
                keywords = {
                    FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test",   alt = { "TESTING", "PASSED", "FAILED" } },
                },
                gui_style = { fg = "NONE", bg = "BOLD" },
                merge_keywords = true,
                highlight = {
                    multiline = true,
                    multiline_pattern = "^.",
                    multiline_context = 10,
                    before = "",
                    keyword = "wide",
                    after = "fg",
                    pattern = [[.*<(KEYWORDS)\s*:]],
                    comments_only = true,
                    max_line_len = 400,
                    exclude = {},
                },
                colors = {
                    error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn",  "WarningMsg", "#FBBF24" },
                    info    = { "DiagnosticInfo", "#2563EB" },
                    hint    = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test    = { "Identifier", "#FF00FF" },
                },
                search = {
                    command = "rg",
                    args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
                    pattern = [[\b(KEYWORDS):]],
                },
            })
        end,
    },

    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end,
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: Open" },
            { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
            { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: File history" },
        },
    },
}
