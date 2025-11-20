---@brief
---
--- https://github.com/luals/lua-language-server
---
--- Lua language server.
---
--- `lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).
---
--- The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.
---
--- If you primarily use `lua-language-server` for Neovim, and want to provide completions,
--- analysis, and location handling for plugins on runtime path, you can use the following
--- settings.
---
--- See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
--- * [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
--- * [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)
---

return {
    name = 'lua_ls',
    cmd = { 'lua-language-server' },
    on_init = function (client)
        client.alias_name = 'Lua(lua_ls)'
    end,
    on_attach = function (client, bufnr)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end
    end,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            workspace = {
                checkThirdParty = false,
                -- library = {
                --     vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths
                -- here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
                -- }
                -- Or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on
                -- your own configuration.
                -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                library = {
                    vim.api.nvim_get_runtime_file('', true),
                    vim.env.VIMRUNTIME .. '/lua',
                    vim.env.VIMRUNTIME .. '/lua/vim/lsp'
                }}
        }
    }
}
