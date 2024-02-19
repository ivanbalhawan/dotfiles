require("mason").setup()
require("mason-lspconfig").setup()
local lsp = require "lspconfig"
local telescope_builtin = require("telescope.builtin")


-- Configure Lua LSP for neovim configuration
-- lsp.lua_ls.setup(coq.lsp_ensure_capabilities({}))
-- Configure GDScript LSP for Godot development

-- Set up lspconfig.
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').lua_ls.setup {
    capabilities = cmp_capabilities
}

lsp.gdscript.setup({
    flags= {
        debounce_text_changes = 150,
    }
})

lsp.pyright.setup({
    -- single_file_support = false,
    capabilities = cmp_capabilities,
    -- settings = {
    --     pylsp = {
    --         plugins = {
    --             pycodestyle = {
    --                 maxLineLength = 100
    --             },
    --         }
    --     }
    -- }
})


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
      -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, {})
    vim.keymap.set('n', '<leader>fo', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
