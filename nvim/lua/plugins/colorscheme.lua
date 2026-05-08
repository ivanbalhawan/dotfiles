return {
    { "fneu/breezy" },
    { "shaunsingh/nord.nvim", name = "nord" },
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
    { "ribru17/bamboo.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "Mofiqul/vscode.nvim" },
    { 
        "Mofiqul/adwaita.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("adwaita")
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
