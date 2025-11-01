--[[
    all of lsp configurations
]]


-- find all lsp_*.lua file in config/lua/lsp/
-- and load them
local config_path = vim.fn.stdpath("config")
local folder_path = config_path .. "/lua/lsp"
local files = vim.fn.glob(folder_path .. "/lsp_*.lua", false, true)
for _, f in ipairs(files) do
    local lsp_module = "lsp." .. f:match(".*/(.*)%.lua$")
    require(lsp_module)
end

-- Renames all references to the symbol under the cursor
vim.api.nvim_create_user_command("Rename", "lua vim.lsp.buf.rename()", { nargs = 0 })
-- Show diagnostics in a floating window
vim.api.nvim_create_user_command("Errors", "lua vim.diagnostic.open_float()", { nargs = 0 })
-- Selects a code action available at the current cursor position
vim.api.nvim_create_user_command("Action", "lua vim.lsp.buf.code_action()", { nargs = 0 })
vim.api.nvim_set_keymap('i', '<C-x><C-o>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = 'Code action' })
-- Enables or disables inlay hints for the scope
vim.api.nvim_create_user_command("Hint", "lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", {nargs = 0});
vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = true })
-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = true })
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = true })

-- Some diagnostic configurations
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN]  = '▲',
            [vim.diagnostic.severity.INFO]  = '»',
            [vim.diagnostic.severity.HINT]  = '⚑',
        },
    },
    virtual_text = false,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})

