return {
    { "fneu/breezy" },
    { "shaunsingh/nord.nvim", name = "nord" },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    { "ribru17/bamboo.nvim" },
    { "Mofiqul/adwaita.nvim" },
    { "Mofiqul/vscode.nvim" },
    { 
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = { separator_style = "thin" },
        },
    },
}
