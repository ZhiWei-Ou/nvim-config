--- @brief: nvim-treesitter setup
--- @refer: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
--- @path: ls ~/.local/share/nvim/site/**

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,

  build = ':TSUpdate',

  opts = {
  },
  config = function ()
    require'nvim-treesitter'.setup{
      install_dir = vim.fn.stdpath('data') .. '/site'
    }

    vim.api.nvim_create_user_command('TSInstallPath', function()
      print(vim.fn.stdpath('data') .. '/site')
    end, {})

    vim.api.nvim_create_user_command('TSInstallInfo', function()
      local list = require('nvim-treesitter').get_installed()
      print(vim.inspect(list))
    end, {})


    vim.filetype.add {
      pattern = {
        -- ssh config
        ['.*%/.*%.?ssh%.config']         = 'sshconfig',
        ['.*%/.*%.?ssh%/config']         = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%.config']     = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%/config']     = 'sshconfig',
        ['.*%/.*%.?ssh%/.*%/.*%.config'] = 'sshconfig',
        ['rc.local']                     = 'bash',
      },
    }

    local installed_list = require('nvim-treesitter').get_installed()
    local can_install_list = require('nvim-treesitter').get_available()

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ft = args.match

        -- I not found `sh` in `nvim-treesitter` available install list
        -- So if file type is `sh`, change it to `bash` to ensure it works correctly
        if ft == 'sh' then
          ft = 'bash'
        end

        -- Check if the file type treesitter can be installed
        if not vim.tbl_contains(can_install_list, ft) then
          return
        end

        -- If open a file that has not been installed, install it
        if not vim.tbl_contains(installed_list, ft) then
          require('nvim-treesitter').install(ft)
        end

        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
