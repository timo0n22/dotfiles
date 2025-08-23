return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
  },
  config = function()
    -- Make UndoTree float with transparency
    vim.g.undotree_WindowLayout = 3 -- vertical split + diff
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_SetFocusWhenToggle = 1

    -- Ensure transparency
    vim.api.nvim_set_hl(0, "UndoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "UndoTreeDiff", { bg = "none" })
  end,
}

