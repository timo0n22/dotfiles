return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true, -- ⬅️ important
        theme = "dragon",   -- use Kanagawa Dragon
      })
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
