-- Оптимизированная конфигурация Neovim
-- Базовые настройки
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.conceallevel = 2
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Прозрачный фон
local function set_transparent_background()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
end

-- Установка и настройка Lazy.nvim
local function setup_lazy()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

setup_lazy()

-- Определение плагинов
local plugins = {
  -- LSP
  {
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
  },

  -- Автодополнение
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Дерево файлов
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Статуслайн
  "nvim-lualine/lualine.nvim",

  -- Тема
  "rebelot/kanagawa.nvim",

  -- GitHub Copilot
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
      vim.g.copilot_ignore_filetypes = {
        ["help"] = true,
        ["gitcommit"] = true,
      }
    end
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "float",
          width = 0.8,
          height = 0.7,
        },
        prompts = {
          explain = "Объясни этот код на русском:",
          refactor = "Улучши этот код, сохраняя логику:",
        }
      })
    end
  },

  -- Obsidian интеграция
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,  -- Изменено с true на false для гарантированной загрузки при старте
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
        require("obsidian").setup({
  dir = "~/SecondBrain",
  notes_subdir = "notes",
  note_id_func = function(title)
    -- Возвращаем точное название заметки без генерации ID
    return title
  end,
  note_path_func = function(spec)
    -- Создаем заметку в папке notes с точным названием
    local path = "notes/" .. spec.id .. ".md"
    return path
  end,
  templates = {
    subdir = "templates",
    date_format = "%d-%m-%Y",
    time_format = "%H:%M",
    -- Указываем шаблон по умолчанию, который будет использоваться 
    -- при создании новых заметок
    default_template = "default.md",
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  -- Явная настройка создания заметок
  new_notes_location = "notes_subdir",
  disable_frontmatter = false,  -- Включаем для поддержки метаданных в шаблонах
  
  -- Обработка переменных шаблона
  use_template_tags = true,
  template_tags = {
    -- Добавляем поддержку пользовательских тегов в шаблонах
    date = function()
      return os.date("%d-%m-%Y")
    end,
    time = function()
      return os.date("%H:%M")
    end,
    -- Можно добавить собственные теги
      },
    })
    end,
  },

  -- Дебаггер
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
  },

  -- Подсветка синтаксиса
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "lua", "vim", "bash" },
        highlight = { enable = true },
      })
    end
  },

  -- Git
  "lewis6991/gitsigns.nvim",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },

  -- Автоматические пары скобок
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}

-- Загрузка плагинов
require("lazy").setup(plugins)

-- Настройка темы
vim.cmd("colorscheme kanagawa")
set_transparent_background()

-- Конфигурация плагинов
local function setup_plugins()
  -- NvimTree
  require("nvim-tree").setup()

  -- Lualine
  require("lualine").setup()

  -- Настройка nvim-cmp
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
      { name = "copilot" },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    }),
    experimental = {
      ghost_text = true,
    },
  })

  -- Загрузка сниппетов
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets/go" } })

  -- Настройка autopairs
  local autopairs = require('nvim-autopairs')
  autopairs.setup({
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = true,
    disable_in_visualblock = true,
    enable_check_bracket_line = true,
  })

  -- Интеграция autopairs с cmp
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

  -- Настройка DAP
  require("dap-go").setup()
  require("dapui").setup()

  -- Настройка Telescope
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    }
  })

  -- Загрузка расширений Telescope
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "ui-select")

  -- Настройка Obsidian
  -- Обновленная регистрация команды для создания заметок
-- Эту функцию нужно добавить в блок setup_obsidian_integration

local function setup_obsidian_integration()
  local ok, obsidian = pcall(require, "obsidian")
  if not ok then return end
  
  -- Правильная регистрация команды для создания заметок с выбором шаблона
  vim.api.nvim_create_user_command("ObsidianNew", function(opts)
    local client = obsidian.get_client()
    if not client then
      vim.notify("Клиент Obsidian не доступен", vim.log.levels.ERROR)
      return
    end
    
    -- Проверяем наличие директории шаблонов
    if not client:templates_dir() then
      vim.notify("Директория шаблонов не настроена или не существует", vim.log.levels.ERROR)
      return
    end
    
    -- Создаем заметку без записи на диск
    local note
    if opts.args and opts.args:len() > 0 then
      note = client:create_note({ title = opts.args, no_write = true })
    else
      local title = vim.fn.input("Название заметки: ")
      if not title or title == "" then
        vim.notify("Отменено создание заметки", vim.log.levels.WARN)
        return
      end
      note = client:create_note({ title = title, no_write = true })
    end
    
    -- Открываем заметку в новом буфере
    client:open_note(note, { sync = true })
    
    -- Используем picker для выбора шаблона
    local picker = client:picker()
    if not picker then
      vim.notify("Picker не настроен", vim.log.levels.ERROR)
      return
    end
    
    picker:find_templates({
      callback = function(name)
        client:write_note_to_buffer(note, { template = name })
      end,
    })
  end, { nargs = "?" })
  
  -- Добавляем команду для быстрого создания заметки с конкретным шаблоном
  vim.api.nvim_create_user_command("ObsidianNewWithTemplate", function(opts)
    local client = obsidian.get_client()
    if not client then
      vim.notify("Клиент Obsidian не доступен", vim.log.levels.ERROR)
      return
    end
    
    -- Ожидаем два аргумента: название заметки и название шаблона
    local args = vim.split(opts.args, " ", { plain = true, trimempty = true })
    if #args < 1 then
      vim.notify("Требуется название заметки и опционально название шаблона", vim.log.levels.ERROR)
      return
    end
    
    local title = args[1]
    local template = args[2] or "default.md" -- Используем default.md если не указан шаблон
    
    -- Создаем заметку
    local note = client:create_note({ title = title, no_write = true })
    if not note then
      vim.notify("Не удалось создать заметку", vim.log.levels.ERROR)
      return
    end
    
    -- Открываем заметку
    client:open_note(note, { sync = true })
    
    -- Применяем указанный шаблон
    client:write_note_to_buffer(note, { template = template })
    vim.notify("Создана заметка с шаблоном " .. template .. ": " .. title, vim.log.levels.INFO)
  end, { nargs = "+" })
end

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = setup_obsidian_integration,
  })

-- GitSigns настройка
local function setup_gitsigns()
  require("gitsigns").setup({
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,  -- Показывать значки в колонке с номерами строк
    numhl      = false, -- Выделять номера строк
    linehl     = false, -- Выделять строки
    word_diff  = false, -- Выделять измененные слова
    watch_gitdir = {
      interval = 1000,
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Показывать информацию о коммите для текущей строки
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Используется для форматирования сообщений из `:Gitsigns status_dict`
    max_file_length = 40000,
    preview_config = {
      -- Опции для окна предпросмотра
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1
    },
    yadm = {
      enable = false
    },
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- Навигация между изменениями
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Следующее изменение" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Предыдущее изменение" })

      -- Действия с изменениями
      map("n", "<leader>gs", require("gitsigns").stage_hunk, { desc = "Git: Stage hunk" })
      map("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "Git: Reset hunk" })
      map("v", "<leader>gs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git: Stage hunk" })
      map("v", "<leader>gr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git: Reset hunk" })
      map("n", "<leader>gS", require("gitsigns").stage_buffer, { desc = "Git: Stage buffer" })
      map("n", "<leader>gu", require("gitsigns").undo_stage_hunk, { desc = "Git: Undo stage hunk" })
      map("n", "<leader>gR", require("gitsigns").reset_buffer, { desc = "Git: Reset buffer" })
      map("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "Git: Preview hunk" })
      map("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Git: Blame line" })
      map("n", "<leader>gB", require("gitsigns").toggle_current_line_blame, { desc = "Git: Toggle line blame" })
      map("n", "<leader>gd", require("gitsigns").diffthis, { desc = "Git: Diff this" })
      map("n", "<leader>gD", function() require("gitsigns").diffthis("~") end, { desc = "Git: Diff ~" })
      map("n", "<leader>gt", require("gitsigns").toggle_deleted, { desc = "Git: Toggle deleted" })
      
      -- Текстовые объекты
      map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git: Select hunk" })
    end
  })
end

-- Вызываем функцию настройки GitSigns в конце setup_plugins
setup_gitsigns()

end

setup_plugins()

-- Сохранение всех пользовательских маппингов
local function setup_keymaps()

    -- Git - дополнительные глобальные команды
vim.keymap.set("n", "<leader>gg", function()
  -- Открываем Git status в новом терминале
  vim.cmd("botright split")
  vim.cmd("terminal git status")
  vim.cmd("resize 15")
  vim.cmd("startinsert")
end, { desc = "Git: Status" })

vim.keymap.set("n", "<leader>gl", function()
  -- Открываем Git log в новом терминале с форматированием
  vim.cmd("botright split")
  vim.cmd("terminal git log --oneline --graph --decorate --all -n 20")
  vim.cmd("resize 15")
end, { desc = "Git: Log" })

vim.keymap.set("n", "<leader>gf", function()
  -- Список измененных файлов через Telescope
  require("telescope.builtin").git_status()
end, { desc = "Git: Changed files" })

vim.keymap.set("n", "<leader>gC", function()
  -- Создать коммит
  vim.cmd("botright split")
  vim.cmd("terminal git commit")
  vim.cmd("resize 15")
  vim.cmd("startinsert")
end, { desc = "Git: Commit" })

vim.keymap.set("n", "<leader>gP", function()
  -- Git push
  vim.cmd("botright split")
  vim.cmd("terminal git push")
  vim.cmd("resize 10")
end, { desc = "Git: Push" })

vim.keymap.set("n", "<leader>gF", function()
  -- Git fetch
  vim.cmd("botright split")
  vim.cmd("terminal git fetch --all")
  vim.cmd("resize 10")
end, { desc = "Git: Fetch" })

vim.keymap.set("n", "<leader>gm", function()
  -- Список измененных файлов через Telescope
  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if msg then
      vim.cmd("botright split")
      vim.cmd("terminal git commit -m " .. vim.fn.shellescape(msg))
      vim.cmd("resize 10")
    end
  end)
end, { desc = "Git: Commit with message" })


  -- Copilot
  vim.keymap.set("i", "<leader>v", 'copilot#Accept("<CR>")', {
    silent = true,
    expr = true,
    script = true,
    replace_keycodes = false,
  })

  -- CopilotChat
  local chat = require("CopilotChat")
  vim.keymap.set("n", "<leader>cc", function() chat.toggle() end, { desc = "CopilotChat: Toggle chat" })
  vim.keymap.set("v", "<leader>ce", function() chat.explain() end, { desc = "CopilotChat: Explain code" })
  vim.keymap.set("v", "<leader>cr", function() chat.refactor() end, { desc = "CopilotChat: Refactor code" })

  -- Создание заметки через команду ObsidianNew
vim.keymap.set("n", "<leader>zn", function()
  local title = vim.fn.input("Название заметки: ")
  if title and #title > 0 then
    -- Используем зарегистрированную команду для создания заметки
    vim.cmd("ObsidianNew " .. vim.fn.shellescape(title))
  else
    vim.notify("Отменено создание заметки", vim.log.levels.WARN)
  end
end, { desc = "Создать новую заметку с выбором шаблона" })

-- Поиск заметок через Telescope
vim.keymap.set("n", "<leader>zf", function()
  require("telescope.builtin").find_files({
    prompt_title = "🔍 Obsidian Notes",
    cwd = "~/SecondBrain/notes",
    hidden = true,
  })
end, { desc = "Search Obsidian Notes" })

-- Дополнительно: создание заметки с шаблоном по умолчанию
vim.keymap.set("n", "<leader>zN", function()
  local title = vim.fn.input("Название заметки с шаблоном по умолчанию: ")
  if title and #title > 0 then
    -- Используем команду для создания заметки с конкретным шаблоном
    vim.cmd("ObsidianNewWithTemplate " .. vim.fn.shellescape(title) .. " default.md")
  else
    vim.notify("Отменено создание заметки", vim.log.levels.WARN)
  end
end, { desc = "Создать заметку с шаблоном по умолчанию" })

  -- Движение строк
  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

  -- Центрирование вида
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")

  -- Копирование в системный буфер
  vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
  vim.keymap.set("n", "<leader>Y", [["+Y]])

  -- Навигация по ошибкам
  vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
  vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
  vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
  vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

  -- Telescope
  vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
  vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>", { desc = "Find symbols" })
  vim.keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { desc = "Find references" })

  -- Git
  vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
  vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })

  -- Сохранение и выход
  vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
  vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
  vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Force quit all" })

  -- Буферы
  vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })

  -- LSP
  local lsp = vim.lsp
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
  vim.keymap.set("n", "gd", lsp.buf.definition, { desc = "Go to definition" })
  vim.keymap.set("n", "gr", lsp.buf.references, { desc = "Show references" })
  vim.keymap.set("n", "K", lsp.buf.hover, { desc = "Show documentation" })
  vim.keymap.set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symbol" })
  vim.keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
  vim.keymap.set("n", "<leader>f", function() lsp.buf.format({ async = true }) end, { desc = "Format file" })

  -- NvimTree
  vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
  vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh file tree" })

  -- Markdown Preview
  vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })

  -- Дебаггер
  local dap = require("dap")
  local dapui = require("dapui")
  vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
  vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Debug: Set Conditional Breakpoint" })
  vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
end

setup_keymaps()
