require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = {
            config = {
                workspaces = {
                    volta = "~/notes/volta",
                    home = "~/notes/home"
                },
            },
        },
        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
            },
        },
        ["core.integrations.telescope"] = {},
    }
}
