--[[
    all of lsp configurations

    @refer: https://neovim.io/doc/user/lsp.html
    The following keymaps are created unconditionally when Nvim starts:
    gra gri grn grr grt i_CTRL-S v_an v_in These GLOBAL keymaps are created unconditionally when Nvim starts:
    "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
    "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
    "grn" is mapped in Normal mode to vim.lsp.buf.rename()
    "grr" is mapped in Normal mode to vim.lsp.buf.references()
    "grt" is mapped in Normal mode to vim.lsp.buf.type_definition()
    "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
    CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
    "an" and "in" are mapped in Visual mode to outer and inner incremental selections, respectively, using vim.lsp.buf.selection_range()
]]

-- find all lsp_*.lua file in config/lua/lsp/
-- and load them
local config_path = vim.fn.stdpath("config")
local folder_path = config_path .. "/lua/lsp"

vim.lsp.config('*', require('cmp_nvim_lsp').default_capabilities())

local files = vim.fn.glob(folder_path .. "/lsp_*.lua", false, true)
for _, f in ipairs(files) do
    local lsp_module = "lsp." .. f:match(".*/(.*)%.lua$")
    local ok, mod = pcall(require, lsp_module)

    -- print(lsp_module)

    if not ok then
        vim.notify("Failed to load " .. lsp_module .. ": " .. mod, vim.log.levels.ERROR)
    elseif type(mod) == 'table' then

        vim.lsp.config(mod.name, mod.opts)

    else
        -- nothing to happen
    end
end

