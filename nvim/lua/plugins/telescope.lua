return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ff", function() require("telescope.builtin").find_files() end,             desc = "Find files" },
        { "<leader>fg", function() require("telescope.builtin").git_files() end,              desc = "Git files" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end,                desc = "Buffers" },
        { "<leader>fj", function() require("telescope.builtin").jumplist() end,               desc = "Jumplist" },
        { "<leader>fq", function() require("telescope.builtin").quickfixhistory() end,        desc = "Quickfix history" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,              desc = "Help tags" },
        { "<leader>fs", function() require("telescope.builtin").live_grep() end,              desc = "Live grep" },
        { "<leader>fp", function() require("telescope.builtin").registers() end,              desc = "Registers" },
        { "<leader>fv", function() require("telescope.builtin").lsp_document_symbols() end,  desc = "LSP symbols" },
        { "<leader>fr", function() require("telescope.builtin").commands() end,               desc = "Commands" },
        { "<leader>ft", function() require("telescope.builtin").filetypes() end,              desc = "Filetypes" },
        { "<leader>fm", function() require("telescope.builtin").marks() end,                  desc = "Marks" },
        { "<leader>fM", function() require("telescope.builtin").keymaps() end,               desc = "Keymaps" },
    },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                layout_strategy = "flex",
                mappings = {
                    i = {
                        ["<c-q>"]     = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<c-left>"]  = "preview_scrolling_left",
                        ["<c-down>"]  = "preview_scrolling_down",
                        ["<c-up>"]    = "preview_scrolling_up",
                        ["<c-right>"] = "preview_scrolling_right",
                        ["<m-left>"]  = "results_scrolling_left",
                        ["<m-down>"]  = "results_scrolling_down",
                        ["<m-up>"]    = "results_scrolling_up",
                        ["<m-right>"] = "results_scrolling_right",
                    },
                    n = {
                        ["<c-q>"]     = actions.smart_send_to_qflist + actions.open_qflist,
                        ["<c-left>"]  = "preview_scrolling_left",
                        ["<c-down>"]  = "preview_scrolling_down",
                        ["<c-up>"]    = "preview_scrolling_up",
                        ["<c-right>"] = "preview_scrolling_right",
                        ["<m-left>"]  = "results_scrolling_left",
                        ["<m-down>"]  = "results_scrolling_down",
                        ["<m-up>"]    = "results_scrolling_up",
                        ["<m-right>"] = "results_scrolling_right",
                    },
                },
            },
        })
    end,
}
