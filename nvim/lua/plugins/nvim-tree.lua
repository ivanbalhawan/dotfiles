return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
            vim.keymap.set("n", "?",     api.tree.toggle_help,           opts("Help"))
        end

        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            on_attach = my_on_attach,
            view = { width = 30, side = "right" },
            renderer = { group_empty = true },
            filters = { dotfiles = true },
        })
    end,
}
