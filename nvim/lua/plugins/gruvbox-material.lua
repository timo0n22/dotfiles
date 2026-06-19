return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        treesitter = true,
        telescope = { enabled = true },
        nvim_tree = true,
        cmp = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
