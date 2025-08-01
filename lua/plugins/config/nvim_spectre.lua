--[[ MacOs
    @Link: https://github.com/nvim-pack/nvim-spectre

    You may need run `brew install gnu-sed`
]]

local is_macos = vim.loop.os_uname().sysname == "Darwin"

local sed_args = is_macos
    and { "-i", "", "-E" } -- macOS: 需要空字符串参数表示“无备份”
    or { "-i", "-E" }

require('spectre').setup({

  color_devicons     = true,
  open_cmd           = 'vnew',
  live_update        = false, -- auto execute search again when you write to any file in vim
  lnum_for_results   = true, -- show line number for search/replace results
  line_sep_start     = '┌-----------------------------------------',
  result_padding     = '¦  ',
  line_sep           = '└-----------------------------------------',
  highlight          = {
    ui = "String",
    search = "DiffChange",
    delete = "DiffDelete",
    add = "DiffAdd"
  },
  mapping            = {
    ['tab'] = {
      map = '<Tab>',
      cmd = "<cmd>lua require('spectre').tab()<cr>",
      desc = 'next query'
    },
    ['shift-tab'] = {
      map = '<S-Tab>',
      cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
      desc = 'previous query'
    },
    ['toggle_line'] = {
      map = "dd",
      cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
      desc = "toggle item"
    },
    ['enter_file'] = {
      map = "<cr>",
      cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
      desc = "open file"
    },
    ['send_to_qf'] = {
      map = "<leader>q",
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = "send all items to quickfix"
    },
    ['replace_cmd'] = {
      map = "<leader>c",
      cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
      desc = "input replace command"
    },
    ['show_option_menu'] = {
      map = "<leader>o",
      cmd = "<cmd>lua require('spectre').show_options()<CR>",
      desc = "show options"
    },
    ['run_current_replace'] = {
      map = "<leader>rc",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace current line"
    },
    ['run_replace'] = {
      map = "<leader>R",
      cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
      desc = "replace all"
    },
    ['change_view_mode'] = {
      map = "<leader>v",
      cmd = "<cmd>lua require('spectre').change_view()<CR>",
      desc = "change result view mode"
    },
    ['change_replace_sed'] = {
      map = "trs",
      cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
      desc = "use sed to replace"
    },
    ['change_replace_oxi'] = {
      map = "tro",
      cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
      desc = "use oxi to replace"
    },
    ['toggle_live_update'] = {
      map = "tu",
      cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
      desc = "update when vim writes to file"
    },
    ['toggle_ignore_case'] = {
      map = "ti",
      cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
      desc = "toggle ignore case"
    },
    ['toggle_ignore_hidden'] = {
      map = "th",
      cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
      desc = "toggle search hidden"
    },
    ['resume_last_search'] = {
      map = "<leader>l",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "repeat last search"
    },
    ['select_template'] = {
      map = '<leader>rp',
      cmd = "<cmd>lua require('spectre.actions').select_template()<CR>",
      desc = 'pick template',
    },
    ['delete_line'] = {
      map = '<leader>rd',
      cmd = "<cmd>lua require('spectre.actions').run_delete_line()<CR>",
      desc = 'delete line',
    },
    -- you can put your mapping here it only use normal mode
  },
  find_engine        = {
    -- rg is map with finder_cmd
    ['rg'] = {
      cmd = "rg",
      -- default args
      args = {
        -- never: Colors will never be used.
        -- auto: The default. ripgrep tries to be smart.
        -- always: Colors will always be used regardless of where output is sent.
        -- ansi: Like 'always', but emits ANSI escapes (even in a Windows
        '--color=auto',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      options = {
        ['ignore-case'] = {
          value = "--ignore-case",
          icon = "[Aa]",
          desc = "Match case"
        },
        ['whole-word'] = {
          value = "-w",
          desc = "Match whole word",
          icon = "[W]"
        },
        ['word-regexp'] = {
          value = "--word-regexp",
          desc = "Use regular expression",
          icon = "[.*]"
        },
        -- you can put any rg search option you want here it can toggle with
        -- show_option function
      }
    },
    ['ag'] = {
      cmd = "ag",
      args = {
        '--vimgrep',
        '-s'
      },
      options = {
        ['ignore-case'] = {
          value = "-i",
          icon = "[I]",
          desc = "ignore case"
        },
        ['hidden'] = {
          value = "--hidden",
          desc = "hidden file",
          icon = "[H]"
        },
      },
    },
  },
  replace_engine     = {
    ["sed"] = {
      cmd = "sed",
      args = sed_args,
    },
    ['oxi'] = {
      cmd = 'oxi',
      args = {},
      options = {
        ['ignore-case'] = {
          value = "i",
          icon = "[I]",
          desc = "ignore case"
        },
      }
    },
    ['sd'] = {
      cmd = "sd",
      options = {},
    },
  },
  default            = {
    find = {
      --pick one of item in find_engine
      cmd = "rg",
      options = { "ignore-case" }
    },
    replace = {
      --pick one of item in replace_engine
      cmd = "sed"
    }
  },
  replace_vim_cmd    = "cdo",
  use_trouble_qf     = false, -- use trouble.nvim as quickfix list
  is_open_target_win = true, --open file on opener window
  is_insert_mode     = false, -- start open panel on is_insert_mode
  is_block_ui_break  = false, -- mapping backspace and enter key to avoid ui break
  open_template      = {
    -- an template to use on open function
    -- see the 'custom function' section below to learn how to configure the template
    -- { search_text = 'text1', replace_text = '', path = "" }
  }
})
