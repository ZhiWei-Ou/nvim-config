local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local function get_base_file_name(uppercase, replace_dot_with_underscore, with_extension)
  local filepath = vim.api.nvim_buf_get_name(0)
  local filename

  if with_extension then
    filename = vim.fn.fnamemodify(filepath, ":t")
  else
    filename = vim.fn.fnamemodify(filepath, ":t:r")
  end

  if uppercase then
    filename = filename:upper()
  end

  if replace_dot_with_underscore then
    filename = filename:gsub("%.", "_")
  end

  return filename
end

ls.setup({
  keep_roots = true,
  link_roots = true,
  link_children = true,

  -- Update more often, :h events for more info.
  update_events = "TextChanged,TextChangedI",
  -- Snippets aren't automatically removed if their text is deleted.
  -- `delete_check_events` determines on which events (:h events) a check for
  -- deleted snippets is performed.
  -- This can be especially useful when `history` is enabled.
  delete_check_events = "TextChanged",
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "choiceNode", "Comment" } },
      },
    },
  },
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 300,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = true,
  -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
  -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
  store_selection_keys = "<Tab>",
  -- luasnip uses this function to get the currently active filetype. This
  -- is the (rather uninteresting) default, but it's possible to use
  -- eg. treesitter for getting the current filetype by setting ft_func to
  -- require("luasnip.extras.filetype_functions").from_cursor (requires
  -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
  -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
  ft_func = function()
    return vim.split(vim.bo.filetype, ".", true)
  end,
})

ls.env_namespace(
  "USER",
  {
    vars = {
      NAME = os.getenv("NP_NAME"),
      EMAIL = os.getenv("NP_EMAIL"),
    }
  }
)

-- File Header Comment
local c_fhc = s("fhc", d(1, function(args, parent)
  local env = parent.snippet.env
  return sn(nil, t {
    "/**",
    " * @file: " .. get_base_file_name(false, false, true),
    " * @author: " .. env.USER_NAME,
    " * @email: " .. env.USER_EMAIL,
    " * @data: " .. os.date("%Y-%m-%d"),
    " * @details: ",
    " */",
    "",
  })
end, {}))
local lua_fhc = s("fhc", d(1, function(args, parent)
  local env = parent.snippet.env
  return sn(nil, t {
    "--[[",
    "File: " .. get_base_file_name(false, false, true),
    "Author: " .. env.USER_NAME,
    "Email: " .. env.USER_EMAIL,
    "Created On: " .. os.date("%Y-%m-%d"),
    "Description: ",
    "]]",
    "",
  })
end, {}))
local cmake_fhc = s("fhc", d(1, function(args, parent)
  local env = parent.snippet.env
  return sn(nil, t {
    "# =============================================================================",
    "# File: " .. get_base_file_name(false, false, true),
    "# Author: " .. env.USER_NAME,
    "# Email: " .. env.USER_EMAIL,
    "# Created On: " .. os.date("%Y-%m-%d"),
    "# Description: ",
    "# ============================================================================",
    "",
    "cmake_minimum_required(VERSION 3.10)",
    "",
  })
end, {}))
local shell_fhc = s("fhc", d(1, function(args, parent)
  local env = parent.snippet.env
  return sn(nil, t {
    "#!/bin/bash",
    "# ============================================================================",
    "# File: " .. get_base_file_name(false, false, true),
    "# Author: " .. env.USER_NAME,
    "# Email: " .. env.USER_EMAIL,
    "# Created On: " .. os.date("%Y-%m-%d"),
    "# Description: ",
    "# ============================================================================",
    "",
  })
end, {}))


-- C/C++ linkage compatibility
local c_clc = s("clc", d(1, function(args, parent)
  return sn(nil, {
    t {
      "#ifdef __cplusplus",
      "extern \"C\" {",
      "#endif /* __cplusplus */",
      "",
    },
    i(1),
    t {
      "",
      "#ifdef __cplusplus",
      "}",
      "#endif /* __cplusplus */",
    }
  })
end, {}))

-- File Header Guard
local c_fhg = s("fhg", d(1, function(args, parent)
  return sn(nil, { t {
    "#ifndef " .. get_base_file_name(true, true, false) .. "__H_",
    "#define " .. get_base_file_name(true, true, false) .. "__H_",
    "",
  },
    i(1),
    t {
      "",
      "#endif " .. "/* " .. get_base_file_name(true, true, false) .. "__H_ */",
    } })
end, {}))

ls.add_snippets("all", {
});

ls.add_snippets("c", {
  c_fhc,
  c_clc,
  c_fhg
})

ls.add_snippets("cpp", {
  c_fhc,
  c_clc,
  c_fhg
})
ls.add_snippets("lua", {
  lua_fhc
})
ls.add_snippets("cmake", {
  cmake_fhc
})
ls.add_snippets("sh", {
  shell_fhc
})
