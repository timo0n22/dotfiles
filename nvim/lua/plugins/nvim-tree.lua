return
{
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        float = {
          enable = false,
          quit_on_focus_loss = false,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 100,
            row = 1,
            col = 1,
          },
        },
      },
    }
    )
  end
}
