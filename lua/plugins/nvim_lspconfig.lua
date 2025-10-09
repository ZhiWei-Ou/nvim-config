--[[
@brief: nvim lspconfig plugin
@refer: https://github.com/neovim/nvim-lspconfig
]]

local after = 'mason-lspconfig.nvim'
local function _configuration()
    require("lsp.lsp")
    require("mason-lspconfig").setup({
        automatic_enable = true,
        automic_installation = true,
    })

    -- 光标悬停高亮
    vim.o.updatetime = 500     -- CursorHold & CursorHoldI Expect Time (ms)
    vim.api.nvim_exec([[
        augroup LspHighlight
        autocmd!
        autocmd CursorHold  *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved *.c,*.h,*.cpp,*.hpp,*.cc,*.hh,*.go,*.lua,*.sh lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
end

return {
    'neovim/nvim-lspconfig',
    after = after,
    config = _configuration,

    dependencies = after,
}