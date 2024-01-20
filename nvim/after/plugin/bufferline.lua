local highlights = require("nord").bufferline.highlights({
    italic = true,
    bold = true,
})

local bufferline = require("bufferline")
bufferline.setup {
    options = {
        separator_style = "slant",
        custom_filter = function(buf_number, buf_numbers)
            if vim.bo[buf_number].filetype ~= "vimwiki" then
                return true
            end
        end,
    },
    highlights=highlights,
}
