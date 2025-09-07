return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      view = {
        float = {
          enable = true,
          quit_on_focus_loss = true,
          open_win_config = function()
            -- Nearly full screen (no border)
            local width = math.floor(vim.o.columns * 0.98) -- 98% width
            local height = math.floor(vim.o.lines * 0.95) -- 95% height
            return {
              relative = "editor",
              border = "none", -- ⬅️ no border
              width = width,
              height = height,
              col = math.floor((vim.o.columns - width) / 2),
              row = math.floor((vim.o.lines - height) / 2),
            }
          end,
        },
        width = function()
          return math.floor(vim.o.columns * 0.98)
        end,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_label = true,
        indent_markers = { enable = true },
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })
  end,
}

