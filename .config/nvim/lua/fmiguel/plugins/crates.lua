return {
  {
    "saecki/crates.nvim",
    version = "^0.3",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },
}

