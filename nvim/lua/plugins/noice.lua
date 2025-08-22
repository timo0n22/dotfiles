return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        progress = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,        -- use a bottom cmdline for search
        command_palette = true,      -- command line in a floating palette
        long_message_to_split = true,
        inc_rename = true,           -- integrate with inc-rename.nvim
        lsp_doc_border = true,       -- add borders to hover/signature help
      },
      cmdline = {
        enabled = true,
        view = "cmdline_popup",      -- nice popup for commandline
        format = {
          cmdline = { icon = " " },
          search_down = { icon = " " },
          search_up = { icon = " " },
          filter = { icon = "$ " },
          lua = { icon = " " },
          help = { icon = " " },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",          -- borderless to match your transparent setup
          },
          position = {
            row = "90%",
            col = "50%",
          },
          size = {
            width = "60%",
            height = "auto",
          },
        },
        mini = {
          win_options = {
            winblend = 0,            -- transparency consistency
          },
        },
      },
      routes = {
        {
          filter = { event = "msg_show", kind = "search_count" },
          opts = { skip = true },
        },
      },
    })

    -- use nvim-notify as default notification backend
    vim.notify = require("notify")
  end,
}

