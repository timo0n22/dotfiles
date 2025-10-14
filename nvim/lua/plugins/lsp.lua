return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Go
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })

    -- Lua
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })

    -- YAML
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
          },
        },
      },
    })

    -- JSON
    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,
  dependencies = {
    "b0o/schemastore.nvim", -- JSON schemas for jsonls
  },
}
