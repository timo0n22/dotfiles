return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_filetypes = {
        ["*"] = false,
        go = true,
        lua = true,
        markdown = true,
      }
      
      vim.keymap.set("i", "<C-m>", 'copilot#Accept("<CR>")', {
        expr = true,
        script = true,
        silent = true,
        replace_keycodes = false,
      })
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "github/copilot.vim" },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "float",
          width = 0.8,
          height = 0.7,
        }
      })
      
      vim.keymap.set("n", "<leader>cc", function() 
        require("CopilotChat").toggle()
      end, { desc = "CopilotChat: Toggle chat" })
    end
  }
}
