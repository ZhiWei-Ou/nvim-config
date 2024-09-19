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

local author = "Ouzw"
local self_mail = "ouzw.mail@gmail.com"
local company_mail = "ouzhiwei@jointcharging.com"
local self_copyright = "© 2024 [ZhiWei-Ou]. All rights reserved."
local company_copyright = "Copyright (c) Joint"
local function get_base_file_name(upper)
    if (upper) then
        return vim.fn.expand("%:t:r"):upper()
    end
    return vim.fn.expand("%:t:r")
end

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

ls.add_snippets("all", {
    s("hpp", {
        t({"/*"}),
        c(1, {
            t({"", " * " .. self_copyright}),
            t({"", " * " .. company_copyright}),}),
        t({"", " * Author " .. author}),
        c(2, {
            t({"", " * Mail " .. company_mail}),
            t({"", " * Mail " .. self_mail}),}),
        t({"", " * Date " .. os.date("%Y-%m-%d %H:%M:%S")}),
        t({"", " *"}),
        t({"", " */"}),
        t({"", "#pragma once"}),
        t({"", ""}),
    }),
    s("cpp", {
        t({"/*"}),
        c(1, {
            t({"", " * " .. self_copyright}),
            t({"", " * " .. company_copyright}),}),
        t({"", " * Author " .. author}),
        c(2, {
            t({"", " * Mail " .. company_mail}),
            t({"", " * Mail " .. self_mail}),}),
        t({"", " * Date " .. os.date("%Y-%m-%d %H:%M:%S")}),
        t({"", " *"}),
        t({"", " */"}),
        t({"", ""}),
    }),
    s("c", {
        t({"/*"}),
        c(1, {
            t({"", " * " .. self_copyright}),
            t({"", " * " .. company_copyright}),}),
        t({"", " * Author " .. author}),
        c(1, {
            t({"", " * Mail " .. company_mail}),
            t({"", " * Mail " .. self_mail}),}),
        t({"", " * Date " .. os.date("%Y-%m-%d %H:%M:%S")}),
        t({"", " *"}),
        t({"", " */"}),
        t({"", ""}),
    }),
    s("h", {
        t({"/*"}),
        c(1, {
            t({"", " * " .. self_copyright}),
            t({"", " * " .. company_copyright}),}),
        t({"", " * Author " .. author}),
        c(2, {
            t({"", " * Mail " .. company_mail}),
            t({"", " * Mail " .. self_mail}),}),
        t({"", " * Date " .. os.date("%Y-%m-%d %H:%M:%S")}),
        t({"", " *"}),
        t({"", " */"}),
        t({"", "#ifndef __" .. get_base_file_name(true) .. "_H__"}),
        t({"", "#define __" .. get_base_file_name(true) .. "_H__"}),
        t({"", ""}),
        t({"", "#endif /* __" .. get_base_file_name(true) .. "_H__ */"}),
        t({"", ""}),
    }),
})

