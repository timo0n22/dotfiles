return {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").gopls.setup({
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })
    end
  }
