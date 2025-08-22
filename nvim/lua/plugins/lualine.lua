return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "rebelot/kanagawa.nvim" },
  config = function()
    -- Load kanagawa theme for lualine
    local kanagawa = require("kanagawa.colors").setup({ theme = "dragon" })
    local theme = require("lualine.themes.kanagawa")

    -- Override background for transparency
    for _, mode in pairs(theme) do
      for _, section in pairs(mode) do
        section.bg = "none"
      end
    end

    require("lualine").setup({
      options = {
        theme = theme,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        globalstatus = true,
      },
    })
  end,
}

