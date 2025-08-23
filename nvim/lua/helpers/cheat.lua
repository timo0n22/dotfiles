local M = {}

-- Open cht.sh for word under cursor
M.cheat_word = function()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    local lang = vim.bo.filetype
    vim.fn.jobstart(
      { "tmux", "run-shell", string.format("~/bin/cheat.sh %s %s", lang, word) },
      { detach = true }
    )
  else
    vim.notify("No word under cursor", vim.log.levels.WARN)
  end
end

-- Prompt user for custom query
M.cheat_prompt = function()
  vim.ui.input({ prompt = "Cheatsheet query: " }, function(input)
    if input ~= nil and input ~= "" then
      vim.fn.jobstart({ "tmux", "run-shell", string.format("~/bin/cheat.sh %s", input) }, { detach = true })
    end
  end)
end

return M

