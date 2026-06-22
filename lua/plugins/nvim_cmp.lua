---@brief nvim-cmp setup
---@refer https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lua" },
    { "milanglacier/minuet-ai.nvim" },
    { "onsails/lspkind-nvim" },
    { "L3MON4D3/LuaSnip" },
  },
  config = function()
    local cmp = require("cmp")
    -- local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    local function apply_cmp_highlights()
      vim.api.nvim_set_hl(0, "CmpNormal", { link = "Pmenu" })
      vim.api.nvim_set_hl(0, "CmpBorder", { link = "FloatBorder" })
      vim.api.nvim_set_hl(0, "CmpSel", { link = "PmenuSel" })
      vim.api.nvim_set_hl(0, "CmpDocNormal", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "CmpDocBorder", { link = "FloatBorder" })
    end

    apply_cmp_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("NvimCmpHighlights", { clear = true }),
      callback = apply_cmp_highlights,
    })

    local function minuet_accept()
      local ok, virtualtext = pcall(require, "minuet.virtualtext")
      if not ok then
        return false
      end

      if virtualtext.action.is_visible() then
        virtualtext.action.accept()
        return true
      end

      return false
    end

    cmp.setup {
      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if minuet_accept() then
            return
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

      },
      snippet = {
        expand = function(args)
          -- select a snippet engine
          require 'luasnip'.lsp_expand(args.body)
          -- vim.snippet.expand(args.body)
        end
      },
      sources = {
        { name = "minuet",        priority = 1000 },    -- AI completion
        { name = "nvim_lsp" },                          -- For nvim-lsp
        { name = "ultisnips" },                         -- For ultisnips user.
        { name = "path" },                              -- for path completion
        { name = "buffer",        keyword_length = 2 }, -- for buffer word completion
        { name = "emoji",         insert = true },      -- emoji completion
        { name = "luasnip", },
        { name = "signature_help" },
      },
      completion = {
        keyword_length = 1,
        completeopt = "menu,noselect",
      },
      view = {
        entries = "custom",
      },
      -- refer: https://github-wiki-see.page/m/hrsh7th/nvim-cmp/wiki/Menu-Appearance
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(_, item)
          local kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
          }
          -- local vscode_like_icons = {
          --   -- Text = '  ',
          --   Text = '<T> ',
          --   Method = '  ',
          --   Function = '  ',
          --   Constructor = '  ',
          --   Field = '  ',
          --   Variable = '  ',
          --   Class = '  ',
          --   Interface = '  ',
          --   Module = '  ',
          --   Property = '  ',
          --   Unit = '  ',
          --   Value = '  ',
          --   Enum = '  ',
          --   Keyword = '  ',
          --   Snippet = '  ',
          --   Color = '  ',
          --   File = '  ',
          --   Reference = '  ',
          --   Folder = '  ',
          --   EnumMember = '  ',
          --   Constant = '  ',
          --   Struct = '  ',
          --   Event = '  ',
          --   Operator = '  ',
          --   TypeParameter = '<T> ',
          -- }
          item.kind = kind_icons[item.kind] or ""
          return item
        end,
      },
      window = {
        -- documentation = cmp.config.window.bordered()
        completion = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:CmpSel",
          winblend = vim.o.pumblend,
          scrolloff = 0,
          col_offset = 0,
          side_padding = 1,
          scrollbar = false,
        },
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          winhighlight = "NormalFloat:CmpDocNormal,FloatBorder:CmpDocBorder",
        },
      },
      -- experimental = {
      --     ghost_text = true,
      -- },
    }

    cmp.setup.filetype("tex", {
      sources = {
        { name = "omni" },
        { name = "ultisnips" },                    -- For ultisnips user.
        { name = "buffer",   keyword_length = 2 }, -- for buffer word completion
        { name = "path" },                         -- for path completion
      },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

  end,
}
