--- @brief: toggleterm.nvim setup
--- @refer: https://github.com/akinsho/toggleterm.nvim

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require 'toggleterm'.setup {
      float_opts = {
        border = 'double',
        -- winblend = 10, -- display not expected, commit issue: https://github.com/akinsho/toggleterm.nvim/issues/617
        title_pos = 'center',
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return ""
        end
      },
      autochdir = true,
      persist_mode = true,
      shade_terminals = false,
      shading_factor = -30,
      shading_ratio = -3,
    }

    vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-j>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }

      -- Disable <esc>, use jk instead, many operation require the use of "esc",
      -- and activating it might conflict with work.
      -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


    -- open existing file in buffer
    vim.api.nvim_create_autocmd("TermEnter", {
      pattern = "term://*toggleterm#*",
      callback = function()
        vim.keymap.set("n", "gx", function()
          local word = vim.fn.expand("<cfile>")

          if vim.fn.file_readable(word) ~= 1 then
            -- vim.notify("File does not exist: " .. path, vim.log.levels.WARN)
            return
          end

          if word ~= "" then
            vim.cmd("q")             -- exit toggleterm
            vim.cmd("edit " .. word) -- open file
          end
        end, { buffer = true, desc = "Open file in buffer inside toggleterm" })
      end,
    })
  end
  ,
}
