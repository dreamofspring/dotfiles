vim.o.termguicolors = true
local dark_theme = 'kanagawa-wave'
local light_theme = 'kanagawa-lotus'

function choose_theme()
  if vim.o.background == 'dark' then
    vim.cmd(string.format('color %s', dark_theme))
    return
  end
  vim.cmd(string.format('color %s', light_theme))
end

vim.api.nvim_create_autocmd('User', {
  pattern = {'LumenLight', 'LumenDark'},
  callback = function()
    choose_theme()
    -- Need to reset these plugins so colors don't look weird
    require'fmiguel.pconfig.lualine'.setup()
    require'fmiguel.pconfig.bufferline'.setup()
  end
})

choose_theme()
