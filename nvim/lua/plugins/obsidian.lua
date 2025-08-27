return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/timon-db",
      },
    },
    daily_notes = {
      folder = "daily",
      date_format = "%d-%m-%Y",
    },
    completion = {
      nvim_cmp = true,
    },
    templates = {
      folder = "templates",
    },
  },
}

