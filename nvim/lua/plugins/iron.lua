return {
    "Vigemus/iron.nvim",
    keys = {
        { "<space>rr", desc = "Toggle REPL" },
        { "<space>rR", desc = "Restart REPL" },
        { "<space>rf", "<cmd>IronFocus<cr>",  desc = "Focus REPL" },
        { "<space>rh", "<cmd>IronHide<cr>",   desc = "Hide REPL" },
        { "<space>sc", desc = "Send motion" },
        { "<space>sf", desc = "Send file" },
        { "<space>sl", desc = "Send line" },
        { "<space>sp", desc = "Send paragraph" },
        { "<space>su", desc = "Send until cursor" },
        { "<space>sb", desc = "Send code block" },
        { "<space>sn", desc = "Send code block and move" },
        { "<space>s<cr>",    desc = "Send CR" },
        { "<space>s<space>", desc = "Interrupt REPL" },
        { "<space>sq", desc = "Exit REPL" },
        { "<space>cl", desc = "Clear REPL" },
    },
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")
        local common = require("iron.fts.common")

        iron.setup({
            config = {
                scratch_repl = true,
                repl_definition = {
                    sh = {
                        command = { "bash" },
                    },
                    python = {
                        command = { "python3" },
                        format = common.bracketed_paste_python,
                        block_dividers = { "# %%", "#%%" },
                        env = { PYTHON_BASIC_REPL = "1" },
                    },
                },
                repl_filetype = function(bufnr, ft)
                    return ft
                end,
                dap_integration = true,
                repl_open_cmd = {
                    view.split.vertical.rightbelow("%40"),
                    view.split.rightbelow("%25"),
                },
            },
            keymaps = {
                toggle_repl              = "<space>rr",
                restart_repl             = "<space>rR",
                send_motion              = "<space>sc",
                visual_send              = "<space>sc",
                send_file                = "<space>sf",
                send_line                = "<space>sl",
                send_paragraph           = "<space>sp",
                send_until_cursor        = "<space>su",
                send_code_block          = "<space>sb",
                send_code_block_and_move = "<space>sn",
                cr                       = "<space>s<cr>",
                interrupt                = "<space>s<space>",
                exit                     = "<space>sq",
                clear                    = "<space>cl",
            },
            highlight = { italic = true },
            ignore_blank_lines = true,
        })
    end,
}
