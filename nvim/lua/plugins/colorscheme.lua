return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      transparent = true,
      background = { light = "lotus", dark = "wave" },
    })
    vim.o.background = "dark" -- "light" для светлой Kanagawa Lotus
    vim.cmd.colorscheme("kanagawa")
  end,
}
