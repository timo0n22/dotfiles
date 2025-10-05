return {
  "rose-pine/neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require("rose-pine").setup {
      -- all the options are explained in the README_STR_PATH
      rose_pine_variant = "moon",
      disable_background = true,
      disable_float_background = true,
      disable_italics = true,
      disable_underline = true,
      disable_underline_matching = true,
      disable_bold = true,
      disable_bold_vertical = true,
      transparent_background = false,
      term_colors = true,
    }
    vim.cmd [[colorscheme rose-pine]]
  end,
}
