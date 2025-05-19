return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    color_overrides = {
      mocha = {
        base = "#000000",
        mantle = "#000000",
        crust = "#000000",
      },
    },
    custom_highlights = function(colors)
      return {
        Normal          = { bg = "#000000" },
        NormalNC        = { bg = "#000000" },
        NormalFloat     = { bg = "#000000" },
        FloatBorder     = { bg = "#000000" },
        Pmenu           = { bg = "#000000" },
        PmenuSel        = { bg = "#222222" },
        TelescopeNormal = { bg = "#000000" },
        TelescopeBorder = { bg = "#000000" },
        MsgArea         = { bg = "#000000" },
        StatusLine      = { bg = "#000000" },
        WinSeparator    = { bg = "#000000" },
        VertSplit       = { bg = "#000000" },
        CursorLine      = { bg = "#000000" },
        SignColumn      = { bg = "#000000" },
        LineNr          = { bg = "#000000" },
        EndOfBuffer     = { bg = "#000000" },
        ColorColumn     = { bg = "#000000" },
        FoldColumn      = { bg = "#000000" },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
