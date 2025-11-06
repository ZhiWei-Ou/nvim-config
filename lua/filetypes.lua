-- Source - https://stackoverflow.com/questions/76086847/how-default-neovim-filetype-sshconfig-for-files-in-ssh-config-d
-- Posted by Tony Sol
-- Retrieved 2025-11-06, License - CC BY-SA 4.0

---@diagnostic disable-next-line: undefined-global
local filetype = vim.filetype

filetype.add {
    pattern = {
        -- ssh config
        ['.*%/.*%.?ssh%.config']         = 'sshconfig',
        ['.*%/.*%.?ssh%/config']         = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%.config']     = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%/config']     = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%/.*%.config'] = 'sshconfig',
    },
}

