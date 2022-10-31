-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "catppuccin"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
vim.g.maplocalleader = ","

-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.keys.normal_mode["]g"] = "<cmd>Gitsign next_hunk<cr>"
lvim.keys.normal_mode["[g"] = "<cmd>Gitsign prev_hunk<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- lvim.keys.normal_mode["]b"] = "<cmd>BufferLineCycleNext<cr>"
-- lvim.keys.normal_mode["[b"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["gR"] = ":Trouble lsp_references<cr>"
lvim.keys.visual_mode["//"] = [[y/\V<C-R>=escape(@",'/\')<CR><CR>]]

-- disable middle-mouse
vim.cmd("noremap <MiddleMouse> <Nop>")
vim.cmd("noremap <2-MiddleMouse> <Nop>")
vim.cmd("noremap <3-MiddleMouse> <Nop>")
vim.cmd("noremap <4-MiddleMouse> <Nop>")

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-e>"] = function(prompt_bufnr, _mode)
      require("trouble.providers.telescope").open_with_trouble(prompt_bufnr, _mode)
    end,
    -- ["<esc>"] = actions.close,
    ["<c-u>"] = false
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}
-- lvim.builtin.telescope.defaults.path_display = { "truncate" }
-- lvim.builtin.telescope.defaults.path_display.shorten = 3

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["c"] = { ":Telescope cder<cr>", "cd" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["Q"] = { ":qa!<cr>", "Quit All" }
lvim.builtin.which_key.mappings["E"] = { "<cmd>NvimTreeFocus<cr>", "NvimTreeFocus" }

lvim.builtin.which_key.mappings["s,"] = { "<cmd>Telescope resume<cr>", "Resume" }
lvim.builtin.which_key.mappings["sp"] = { "<cmd>Telescope pickers<cr>", "Pickers" }
lvim.builtin.which_key.mappings["sw"] = { "<cmd>Telescope grep_string<cr>", "Search word under cursor" }

lvim.builtin.which_key.mappings["bp"] = { "<cmd>BufferLineTogglePin<cr>", "Pin" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferKill<cr>", "Close" }

lvim.builtin.which_key.mappings["gf"] = { "<cmd>Gitsign setqflist<cr>", "Gitsign Hunks" }

lvim.builtin.which_key.mappings["S"] = {
  name = "+Session",
  S = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

lvim.builtin.which_key.mappings["H"] = {
  name = "+Harpoon",
  H = { ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Open" },
  f = { ":Telescope harpoon marks<cr>", "Telescope marks" },
  m = { ":lua require('harpoon.mark').add_file()<cr>", "Add File" },
  n = { ":lua require('harpoon.ui').nav_next()<cr>", "Next File" },
  p = { ":lua require('harpoon.ui').nav_prev()<cr>", "Previous File" },
}

lvim.builtin.which_key.mappings["r"] = {
  name = "+Refactoring",
  p = { ":lua require('refactoring').debug.printf({below = true})<CR>", "printf" },
  v = { ":lua require('refactoring').debug.print_var({normal = true})<CR>", "print variable" },
  c = { ":lua require('refactoring').debug.cleanup({})<CR>", "cleanup" },
}

lvim.builtin.which_key.mappings["x"] = {
  name = "+Trouble",
  x = { "<cmd>TroubleToggle<cr>", "Trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "Location" },
  n = { "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", "Next" },
  p = { "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", "Previous" },
}

lvim.builtin.which_key.vmappings["s"] = { ":!sort<cr>", "Sort" }
lvim.builtin.which_key.vmappings["f"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Range Format" }
lvim.builtin.which_key.vmappings["r"] = {
  name = "+Refactoring",
  r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", "Refactor" },
  p = { ":lua require('refactoring').debug.print_var({})<CR>", "printf" }
}

-- Telescope extensions register
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "refactoring")
  pcall(telescope.load_extension, "harpoon")
  pcall(telescope.load_extension, "cder")
end

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
-- lvim.builtin.alpha.mode = "startify"
lvim.builtin.nvimtree.setup.view.width = 40
-- lvim.builtin.lualine.options.theme = "catppuccin"
-- lvim.builtin.lualine.options.globalstatus = true
-- lvim.builtin.comment.mappings.extra = true

lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.persist_size = true
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "htop", "<leader>th", "htop", "float" }

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  b = { "<cmd>TermExec cmd='pyborrow.py' direction=horizontal size=35 go_back=0<cr>", "PyBorrow" },
  c = { "<cmd>ToggleTermSendCurrentLine<cr>", "Send Current Line" },
  a = { "<cmd>ToggleTermToggleAll<cr>", "Toggle All" },
}
lvim.builtin.which_key.vmappings["t"] = {
  name = "+Terminal",
  v = { ":ToggleTermSendVisualSelection<cr>", "Send visually selected text" },
}

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local name = vim.api.nvim_buf_get_name(0)
    if not name:match "lazygit" and not name:match "htop" then
      local opts = { noremap = true }
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    end
  end
})

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.active = true
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "cpp",
  "lua",
  "python",
  "yaml",
  "yang",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.matchup.enable = true

---@usage disable automatic installation of servers
lvim.lsp.automatic_installation = true
-- lvim.lsp.null_ls.setup = { debug = true, log = { level = "trace" } }

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pylsp", "pyright", "clangd" })

local clangd_flags = {
  "--offset-encoding=utf-16", -- for 'multiple client offset encoding' error
  "--all-scopes-completion",
  "--background-index",
  "--pch-storage=disk",
  "--log=verbose",
  "--completion-style=detailed",
  "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--clang-tidy",
  "--query-driver=/home/linuxbrew/.linuxbrew/Cellar/gcc/11.3.0_2",
  "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--compile-commands-dir=build",
}

local clangd_bin = "clangd"

local custom_clangd_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local clangd_opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
  on_attach = custom_clangd_on_attach,
  filetypes = { "c", "cpp" },
}
require("lvim.lsp.manager").setup("clangd", clangd_opts)

local pyls_opts = {
  settings = {
    pylsp = {
      plugins = {
        jedi = {
          extra_paths = {
            -- "/home/dn/cheetah/src/py_packages/dn_common/",
            -- "/home/dn/cheetah/src/py_packages/upgrade_mode",
            -- "/home/dn/cheetah/src/py_packages/transaction_api",
            -- "/home/dn/cheetah/src/py_packages/fe_agent",
            -- "/home/dn/cheetah/src/py_packages/dn_jag_api",
          }
        },
        pycodestyle = {
          ignore = { "E501", "W503" }
        },
        pydocstyle = {
          enabled = false,
          addIgnore = { "D102" }
        },
        yapf = {
          enabled = false
        },
        mypy = {
          enable = false
        },
        black = {
          enabled = true
        }
      }
    }
  }
}

require("lvim.lsp.manager").setup("pylsp", pyls_opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "clang-format", filetypes = { "proto" }, extra_args = { "--style=Google" } },
  { command = "protolint" },
  { command = "clang-format", filetypes = { "yang" } },
  { command = "beautysh", extra_args = { "-i", "2" } },
  -- { command = "black", filetypes = { "python" } },
  --   {
  --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
  --     command = "prettier",
  --     ---@usage arguments to pass to the formatter
  --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
  --     extra_args = { "--print-with", "100" },
  --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
  --     filetypes = { "typescript", "typescriptreact" },
  --   },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "protolint" },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

require("luasnip.loaders.from_lua").load({ paths = "~/snippets" })

-- Additional Plugins
lvim.plugins = {
  { "tpope/vim-unimpaired" },
  { "tpope/vim-surround",
    keys = { "c", "d", "y", "v" },
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    setup = function()
      vim.o.timeoutlen = 500
    end
  },
  { "tpope/vim-repeat" },
  -- { "folke/tokyonight.nvim" },
  {
    "folke/trouble.nvim",
  },
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    keys = { "s", "S" },
    config = function()
      require('leap').set_default_keymaps()
    end
  },
  {
    "ggandor/flit.nvim",
    after = "leap.nvim",
    config = function()
      require('flit').setup {
        keys = { f = 'f', F = 'F', t = 't', T = 'T' },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "nvo",
        multiline = true,
        -- Like `leap`s similar argument (call-specific overrides).
        -- E.g.: opts = { equivalence_classes = {} }
        opts = {}
      }
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require "lsp_signature".setup()
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "p00f/nvim-ts-rainbow",
  },
  -- {
  --   "romgrk/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup {
  --       enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  --       throttle = true, -- Throttles plugin updates (may improve performance)
  --       max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  --       patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
  --         -- For all filetypes
  --         -- Note that setting an entry here replaces all other patterns for this entry.
  --         -- By setting the 'default' entry below, you can control which nodes you want to
  --         -- appear in the context window.
  --         default = {
  --           'class',
  --           'function',
  --           'method',
  --         },
  --       },
  --     }
  --   end
  -- },
  {
    "wellle/targets.vim",
    event = "BufRead"
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.loaded_matchit = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    'ojroques/nvim-osc52',
    config = function()
      -- OSC52
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end

      local function paste()
        return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
      end

      -- Now the '+' register will copy to system clipboard using OSC52
      vim.g.clipboard = {
        name = 'osc52',
        copy = { ['+'] = copy, ['*'] = copy },
        paste = { ['+'] = paste, ['*'] = paste },
      }
    end
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "BufRead"
  },
  {
    "ThePrimeagen/harpoon",
    event = "BufEnter"
  },
  {
    "zane-/cder.nvim",
    event = "BufEnter"
  },
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      local opts = { noremap = true }
      vim.g.tmux_navigator_no_mappings = 1
      vim.api.nvim_set_keymap("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", opts)
      vim.api.nvim_set_keymap("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", opts)
      vim.api.nvim_set_keymap("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", opts)
      vim.api.nvim_set_keymap("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", opts)
      vim.api.nvim_set_keymap("n", "<c-/>", "<cmd>TmuxNavigatePrevious<cr>", opts)
    end
  },
  {
    "nathanalderson/yang.vim"
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          dashboard = true,
          gitsigns = true,
          harpoon = true,
          leap = true,
          lsp_trouble = true,
          fidget = true,
          notify = true,
          nvimtree = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          ts_rainbow = true,
          which_key = true,

          -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.api.nvim_command "colorscheme catppuccin"
    end
  },
  -- {
  --   'j-hui/fidget.nvim',
  --   config = function()
  --     require("fidget").setup({
  --       window = {
  --         blend = 0,
  --       }
  --     })
  --   end
  -- },
  {
    "vigoux/notifier.nvim",
    event = "BufRead",
    config = function()
      require 'notifier'.setup {
        -- You configuration here
      }
    end
  }
}

-- Autocommands (https://eovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".\\=aliases",
  -- enable wrap mode for json files only
  command = "setlocal filetype=zsh",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.conf",
  command = "setlocal filetype=tmux"
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.cmd("command! Darker :!darker %")
    vim.cmd("command! Black :!black % --preview")
    vim.cmd("command! Isort :!isort % --profile black")
    vim.cmd("command! Autoflake :!autoflake % --in-place --remove-unused-variables --remove-rhs-for-unused-variables --remove-duplicate-keys")
    vim.cmd("command! AutoflakePlus :!autoflake % --in-place --remove-all-unused-imports")
  end,
})
