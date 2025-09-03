-- local icon, color = require'nvim-web-devicons'.get_icons_by_operating_system()

-- print(vim.inspect(icon.apple))

local fg_color = '#d1b0fa'

local function os(color)
    local system_name = vim.loop.os_uname().sysname
    local icon

    if system_name == "Darwin" then
        icon = require('mini.icons').get('os', 'macos')
    elseif system_name == "Linux" then
        icon = require('mini.icons').get('os', 'linux')
    elseif system_name == "Windows" then
        icon = require('mini.icons').get('os', 'windows')
    end

    return
    {
        function() return system_name end,
        icon = icon,
        color = { fg = color }
    }
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
            'dashboard',
            'packer',
            'TelescopePrompt',
            -- 'trouble',
            'toggleterm',
            -- 'NvimTree',
        },
        ignore_focus = {
        },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics', },
        lualine_c = {
            { 'filename', separator = { left = '', right = '' }, color = { fg = '#a9a1e1' } },
            {
                function()
                    return '%='
                end,
                separator = { left = '', right = '' },
            },
            {
                -- Lsp server name .
                function()
                    local msg = '*'
                    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                    local clients = vim.lsp.get_clients()
                    if next(clients) == nil then
                        return msg
                    end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                separator = { left = '', right = '' },
                icon = require('mini.icons').get('file', 'init.lua'),
                color = { fg = fg_color, gui = 'bold' },
            }
        },
        lualine_x = {
            { 'encoding', fmt = string.lower,   color = { fg = fg_color } },
            os(fg_color),
            { 'filetype', icons_enabled = true, color = { fg = fg_color } },
        },
        lualine_y = { 'progress' },
        lualine_z = {
            { 'filesize', cond = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end, }
        }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'hostname' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {
        'trouble',
        'fugitive',
        'nvim-tree',
        'mason',
        'man',
        'toggleterm',
        'oil',
    }
}
