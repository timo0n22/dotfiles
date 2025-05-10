return 
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      
  require("nvim-tree").setup({
      view = {
         float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = 100,
              height = 20,
              row = 1,
              col = 1,
            },
          },
      },
  }
  )
    end
  }
