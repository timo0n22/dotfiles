return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<C-f>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-g>",
      },
      color = {
        suggestion_color = "#777B7E",
        cterm = 244,
      },
      log_level = "info",            -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false,       -- disables built in keymaps for more manual control
      condition = function()
        return false
      end
    })
  end,
}
