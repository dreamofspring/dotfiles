return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "0.x.x",
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      require"nvim-treesitter.configs".setup {
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
        additional_vim_regex_highlighting = false,
      }
    end,
  },
}

