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

local function get_base_file_name(uppercase)
    local filepath = vim.api.nvim_buf_get_name(0)

    local filename = vim.fn.fnamemodify(filepath, ":t:r")

    if uppercase then
        filename = filename:upper()
    end

    return filename
end

-- vim.keymap.set({"i", "s"}, "<C-K>", function() ls.expand() end, {silent = true})
--
-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})
--
--

local author = "Ouzw"
local self_mail = "ouzw.mail@gmail.com"
local self_copyright = "© 2024 [ZhiWei-Ou]. All rights reserved."

local company_copyright = "nil"
local company_mail = "nil"

ls.add_snippets("all", {
    -- /*
    --  * @Copyright (c) 2022 [ZhiWei-Ou]. All rights reserved.
    --  * @file foo.h
    --  * @author Ouzw
    --  * @date 2022-01-01
    --
    --  * @brief arg
    --  */
    --  #pragma once
    --
    s("hpph", {
        t(
            {
                '/*',
                ' * ' .. self_copyright,
                '',
            }
        ),
        f(
            function()
                return " * @file " .. get_base_file_name(false) .. ".hpp"
            end,
            {}
        ),
        t(
            {
                '',
                ' * @author ' .. author,
                ' * @mail ' .. self_mail,
                ''
            }
        ),
        f (
            function()
                return " * @date " .. os.date("%Y-%m-%d %H:%M:%S")
            end,
            {}
        ),
        t({'', '', ' * @brief '}),
        i(1),
        t(
            {
                '',
                ' */',
                '#pragma once',
                '',
            }
        ),

    }),


    -- /*
    --  * @Copyright (c) 2022 [ZhiWei-Ou]. All rights reserved.
    --  * @file foo.cpp
    --  * @author Ouzw
    --  * @date 2022-01-01
    --
    --  * @brief arg
    --  */
    s("cpph", {
        t(
            {
                '/*',
                ' * ' .. self_copyright,
                '',
            }
        ),
        f(
            function()
                return " * @file " .. get_base_file_name(false) .. ".cpp"
            end,
            {}
        ),
        t(
            {
                '',
                ' * @author ' .. author,
                ' * @mail ' .. self_mail,
                ''
            }
        ),
        f (
            function()
                return " * @date " .. os.date("%Y-%m-%d %H:%M:%S")
            end,
            {}
        ),
        t({'', '', ' * @brief '}),
        i(1),
        t(
            {
                '',
                ' */',
                '',
            }
        ),

    }),

    -- /*
    --  * @Copyright (c) 2022 [ZhiWei-Ou]. All rights reserved.
    --  * @file foo.c
    --  * @author Ouzw
    --  * @date 2022-01-01
    --
    --  * @brief arg
    --  */
    s("ch", {
        t(
            {
                '/*',
                ' * ' .. self_copyright,
                '',
            }
        ),
        f(
            function()
                return " * @file " .. get_base_file_name(false) .. ".c"
            end,
            {}
        ),
        t(
            {
                '',
                ' * @author ' .. author,
                ' * @mail ' .. self_mail,
                ''
            }
        ),
        f (
            function()
                return " * @date " .. os.date("%Y-%m-%d %H:%M:%S")
            end,
            {}
        ),
        t({'', '', ' * @brief '}),
        i(1),
        t(
            {
                '',
                ' */',
                '',
            }
        ),

    }),

    -- /*
    --  * @Copyright (c) 2022 [ZhiWei-Ou]. All rights reserved.
    --  * @file foo.h
    --  * @author Ouzw
    --  * @date 2022-01-01
    --
    --  * @brief arg
    --  */
    --  #ifndef FOO_H
    --  #define FOO_H
    --
    --  #ifdef __cplusplus
    --  extern "C" {
    --  #endif
    --
    --  #ifdef __cplusplus
    --  }
    --  #endif
    --  #endif /* FOO_H */
    s("hh", {
        t(
            {
                '/*',
                ' * ' .. self_copyright,
                -- ' * @Copyright (c) 2022 [ZhiWei-Ou]. All rights reserved.',
                '',
            }
        ),
        f(
            function()
                return " * @file " .. get_base_file_name(false) .. ".h"
            end,
            {}
        ),
        t(
            {
                '',
                ' * @author ' .. author,
                ' * @mail ' .. self_mail,
                '',
            }
        ),
        f(
            function()
                return " * @date " .. os.date("%Y-%m-%d %H:%M:%S")
            end,
            {}
        ),
        t(
            {
                '',
                ' *',
                ' * @brief ',
            }
        ),
        i(1),
        t(
            {
                '',
                ' */',
                ''
            }
        ),
        f(
            function() 
                return "#ifndef __" .. get_base_file_name(true):upper() .. "_H__"
            end, 
            {}
        ),
        t({"", ""}),
        f(
            function()
                return "#define __" .. get_base_file_name(true):upper() .. "_H__"
            end,
            {}
        ),
        t(
            {
                '',
                '',
                '#ifdef __cplusplus',
                'extern "C" {',
                '#endif',
                '',
                '',
                '#ifdef __cplusplus',
                '}',
                '#endif',
                '',
            }
        ),
        f(
            function()
                return "#endif /* __" .. get_base_file_name(true):upper() .. "_H__ */"
            end,
            {}
        ),
    }),
})

