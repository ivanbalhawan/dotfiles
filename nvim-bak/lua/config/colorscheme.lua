-- vim.cmd([[colorscheme nord]])
-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true

-- Load the colorscheme
require("nord").set()

local highlights = require("nord").bufferline.highlights({
	italic = true,
	bold = true,
	-- fill = "#ffffff"
})

require("bufferline").setup({
	options = {
		separator_style = "slant",
	},
	highlights = highlights,
})
