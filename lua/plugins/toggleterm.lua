---@brief toggleterm.nvim setup
---@refer https://github.com/akinsho/toggleterm.nvim

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  enabled = true,
  keys = {
    {
      "<C-t>",
      "<cmd>ToggleTerm<CR>",
      mode = { "n" },
      desc = "Toggle Terminal"
    },
    {
      "<C-j>",
      "<cmd>ToggleTerm direction=tab<CR>",
      mode = { "n", "t" },
      desc = "Toggle Terminal in new tab"
    }
  },
  opts = {
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
  },
  config = function(_, opts)
    require 'toggleterm'.setup(opts)

    function _G.set_terminal_keymaps()
      local _opts = { buffer = 0 }

      -- Disable <esc>, use jk instead, many operation require the use of "esc",
      -- and activating it might conflict with work.
      -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], _opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


    local function parse_file_target(text)
      if text == "" then
        return nil
      end

      local path, line, col = text:match("^(.+):(%d+):(%d+):?$")
      if path then
        return path, tonumber(line), tonumber(col)
      end

      path, line = text:match("^(.+):(%d+):?$")
      if path then
        return path, tonumber(line), nil
      end

      return text, nil, nil
    end

    local function get_file_target()
      local word = vim.fn.expand("<cfile>")
      local path, line, col = parse_file_target(word)

      if path and vim.fn.file_readable(path) == 1 then
        return path, line, col
      end

      local current_line = vim.api.nvim_get_current_line()
      for match in current_line:gmatch("%S+:%d+:%d+:?") do
        path, line, col = parse_file_target(match)
        if path and vim.fn.file_readable(path) == 1 then
          return path, line, col
        end
      end

      for match in current_line:gmatch("%S+:%d+:?") do
        path, line, col = parse_file_target(match)
        if path and vim.fn.file_readable(path) == 1 then
          return path, line, col
        end
      end
    end

    -- open existing file in buffer
    vim.api.nvim_create_autocmd("TermEnter", {
      pattern = "term://*toggleterm#*",
      callback = function()
        vim.keymap.set("n", "gx", function()
          local path, line, col = get_file_target()

          if not path then
            -- vim.notify("File does not exist: " .. path, vim.log.levels.WARN)
            return
          end

          if path ~= "" then
            vim.cmd("q")                               -- exit toggleterm
            vim.cmd("edit " .. vim.fn.fnameescape(path)) -- open file
            if line then
              vim.api.nvim_win_set_cursor(0, { line, math.max((col or 1) - 1, 0) })
            end
          end
        end, { buffer = true, desc = "Open file in buffer inside toggleterm" })
      end,
    })
  end
  ,
}
