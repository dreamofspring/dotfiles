local o = vim.o
local wo = vim.wo
local g = vim.g
local A = vim.api
local cmd = vim.cmd
g.mapleader = ' '

require('plugins').load()
require('lsp')
require('keybinds').set_general_keybinds()

-- theme setup
cmd[[colorscheme tokyonight-night]]
o.termguicolors = true

o.number = true
o.relativenumber = true
o.cul = true -- highlight current line
wo.wrap = false
o.spell = false
o.mouse = "a" --enable mouse cursor

-- insert spaces for tabs like any civilized dev
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.encoding = 'UTF-8'

-- remove trailing spaces on save
A.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Exit Vim if NERDTree is the only window remaining in the only tab.
A.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = [[if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif]]
})


-- Setup lsp auto-complete
-- ===================================================================
vim.opt.completeopt = {"menu","menuone","noselect"}

local cmp = require('cmp')

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  end,
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' }, -- For luasnip users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})
-- ===================================================================
-- Done setting up lsp auto-complete

-- Autopairs
local npairs = require("nvim-autopairs")
npairs.setup({
    check_ts = true,
    disable_filetype = { "TelescopePrompt" },
    -- do not trigger if a close pair is on the same line
    enable_check_bracket_line = false,
})

-- hide default mode indicator because I'm using lualine
vim.opt.showmode = false


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

require('telescope').setup{
    defaults = {
        file_ignore_patterns = {".git/"},
        prompt_prefix = "> ",
    }
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}

