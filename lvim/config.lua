--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = { "*.lua", "*.c", "*.cpp", "*.h", "*.hpp" },
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
vim.g.maplocalleader = ","
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.keys.normal_mode["U"] = "<nop>"
lvim.keys.normal_mode["]g"] = "<cmd>Gitsign next_hunk<cr>"
lvim.keys.normal_mode["[g"] = "<cmd>Gitsign prev_hunk<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.visual_mode["//"] = [[y/\V<C-R>=escape(@",'/\')<CR><CR>]]

-- disable middle-mouse
vim.cmd("noremap <MiddleMouse> <Nop>")
vim.cmd("noremap <2-MiddleMouse> <Nop>")
vim.cmd("noremap <3-MiddleMouse> <Nop>")
vim.cmd("noremap <4-MiddleMouse> <Nop>")

-- -- Change theme settings
-- lvim.colorscheme = "lunar"
lvim.colorscheme = "tokyonight-night"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false
lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
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

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- lvim.builtin.telescope.defaults.path_display = { "truncate" }
lvim.builtin.telescope.defaults.path_display = { truncate = 3 }
lvim.builtin.telescope.pickers.buffers.initial_mode = "insert"
lvim.builtin.telescope.theme = "center"
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-c>"] = actions.close,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
		["<C-u>"] = false,
		["<C-q>"] = function(...)
			actions.smart_send_to_qflist(...)
			actions.open_qflist(...)
		end,
		["<CR>"] = actions.select_default,
		["<C-w>"] = function(prompt_bufnr)
			-- Use nvim-window-picker to choose the window by dynamically attaching a function
			local action_set = require("telescope.actions.set")
			local action_state = require("telescope.actions.state")

			local picker = action_state.get_current_picker(prompt_bufnr)
			picker.get_selection_window = function(_picker, _)
				local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
				-- Unbind after using so next instance of the picker acts normally
				_picker.get_selection_window = nil
				return picked_window_id
			end

			return action_set.edit(prompt_bufnr, "edit")
		end,
	},
	n = {
		["<C-n>"] = actions.move_selection_next,
		["<C-p>"] = actions.move_selection_previous,
		["<C-q>"] = function(...)
			actions.smart_send_to_qflist(...)
			actions.open_qflist(...)
		end,
	},
}

-- lvim.builtin.bufferline.options.numbers = "ordinal"
lvim.builtin.bufferline.options.indicator.style = "underline"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["q"] = {
	name = "QuickFix",
	j = { ":cnext<cr>", "Next" },
	k = { ":cprev<cr>", "Previous" },
}

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["E"] = { "<cmd>NvimTreeFocus<cr>", "NvimTreeFocus" }
lvim.builtin.which_key.mappings["w"] = {
	name = "+Window",
	w = {
		function()
			local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
			vim.api.nvim_set_current_win(picked_window_id)
		end,
		"Pick Window",
	},
	x = {
		function()
			local window = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
			local target_buffer = vim.fn.winbufnr(window)
			-- Set the target window to contain current buffer
			vim.api.nvim_win_set_buf(window, 0)
			-- Set current window to contain target buffer
			vim.api.nvim_win_set_buf(0, target_buffer)
		end,
		"Swap Windows",
	},
	q = { ":q<CR>", "Quite" },
}

lvim.builtin.which_key.mappings.s.p = { "<cmd>Telescope pickers<cr>", "Pickers" }
lvim.builtin.which_key.mappings.s.b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find in buffer" }
lvim.builtin.which_key.mappings.s.w = { "<cmd>Telescope grep_string<cr>", "Search word under cursor" }
lvim.builtin.which_key.mappings.s.s = { "<cmd>Telescope luasnip<cr>", "Search snippets" }
lvim.builtin.which_key.mappings["c"] = {
	name = "+Cheetah",
	f = { "<cmd>Telescope find_files cwd=~/cheetah hidden=true theme=ivy<cr>", "Find Cheetah" },
	a = { "<cmd>Telescope find_files cwd=~/cheetah hidden=true no_ignore=true<cr>", "Find Cheetah All" },
	t = { "<cmd>Telescope live_grep cwd=~/cheetah<cr>", "Grep Cheetah" },
}

lvim.builtin.which_key.mappings["bp"] = { "<cmd>BufferLineTogglePin<cr>", "Pin" }
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferKill<cr>", "Close" }

lvim.builtin.which_key.mappings["gf"] = { "<cmd>Gitsign setqflist<cr>", "Gitsign Hunks" }
lvim.builtin.which_key.mappings.g.d = nil
lvim.builtin.which_key.mappings["gd"] = {
	name = "+Diffview",
	o = { "<cmd>DiffviewOpen<cr>", "DiffviewOpen" },
	f = { "<cmd>DiffviewFileHistory<cr>", "DiffviewFileHistory" },
	c = { "<cmd>DiffviewClose<cr>", "DiffviewClose" },
}

lvim.builtin.which_key.mappings.S = {
	"<cmd>lua require('persistence').load({ last = true })<cr>",
	"Restore last session",
}

lvim.builtin.which_key.mappings["m"] = {
	name = "+Marks",
	a = { "<cmd>MarksQFListAll<CR>", "All" },
	f = { "<cmd>MarksQFListBuf<CR>", "Buffer" },
	g = { "<cmd>MarksQFListGlobal<CR>", "Global" },
}

-- lvim.builtin.which_key.mappings["t"] = {
-- 	name = "+Trouble",
-- 	t = { "<cmd>TroubleToggle<cr>", "Trouble" },
-- 	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace" },
-- 	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document" },
-- 	q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
-- 	l = { "<cmd>TroubleToggle loclist<cr>", "Location" },
-- 	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
-- 	n = { "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", "Next" },
-- 	p = { "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", "Previous" },
-- }

lvim.builtin.which_key.vmappings["S"] = { ":!sort<cr>", "Sort" }
lvim.builtin.which_key.vmappings["f"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Range Format" }
lvim.builtin.which_key.vmappings["s"] = { "<Plug>VSurround", "Surround" }

-- Telescope extensions register
lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "luasnip")
end

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.nvimtree.setup.view.width = 40
-- lvim.builtin.lualine.options.globalstatus = true
-- lvim.builtin.comment.mappings.extra = true

-- lvim.builtin.terminal.active = false
-- lvim.builtin.terminal.direction = "horizontal"
-- lvim.builtin.terminal.persist_size = true
-- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "htop", "<leader>th", "htop", "float" }

-- lvim.builtin.which_key.mappings["t"] = {
-- 	name = "+Terminal",
-- 	b = { "<cmd>TermExec cmd='pyborrow.py' direction=horizontal size=35 go_back=0<cr>", "PyBorrow" },
-- 	c = { "<cmd>ToggleTermSendCurrentLine<cr>", "Send Current Line" },
-- 	a = { "<cmd>ToggleTermToggleAll<cr>", "Toggle All" },
-- }
-- lvim.builtin.which_key.vmappings["t"] = {
-- 	name = "+Terminal",
-- 	v = { ":ToggleTermSendVisualSelection<cr>", "Send visually selected text" },
-- }

-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	pattern = "term://*",
-- 	callback = function()
-- 		local name = vim.api.nvim_buf_get_name(0)
-- 		if not name:match("lazygit") and not name:match("htop") then
-- 			local opts = { noremap = true }
-- 			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
-- 		end
-- 	end,
-- })

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
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.indent.disable = { "yaml", "python", "c", "cpp" }

-- lvim.builtin.gitsigns.opts.trouble = false

---@usage disable automatic installation of servers
lvim.lsp.automatic_installation = true
lvim.lsp.null_ls.setup = { debug = true, log = { level = "trace" } }

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
	-- "--query-driver=/home/linuxbrew/.linuxbrew/Cellar/gcc/11.3.0_2",
	"--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
	-- "--fallback-style=Google",
	-- "--compile-commands-dir=build",
}

local clangd_bin = "clangd"

local custom_clangd_on_attach = function(client, bufnr)
	require("lvim.lsp").common_on_attach(client, bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
	vim.cmd([[
    setlocal ts=4 sts=4 sw=4 noexpandtab
    noremap <buffer> <localleader>; mmA;<esc>`m
    imap <buffer> <localleader>j <esc>o{<enter>
    map <buffer> <localleader>d $xo{<enter>
    let @t="dwea_t"
    noremap <buffer> <localleader>d] V][d
    command! RemoveRC :%s/int rc = \(.*\);\n\s*if (rc)/if (\1)/e
  ]])
end

local clangd_opts = {
	cmd = { clangd_bin, unpack(clangd_flags) },
	on_attach = custom_clangd_on_attach,
	filetypes = { "c", "cpp" },
}
require("lvim.lsp.manager").setup("clangd", clangd_opts)

-- local pyls_opts = {
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				ruff = {
-- 					enabled = true,
-- 				},
-- 				pycodestyle = {
-- 					enabled = false,
-- 				},
-- 				pyflakes = {
-- 					enabled = false,
-- 				},
-- 				mccabe = {
-- 					enabled = false,
-- 				},
-- 			},
-- 		},
-- 	},
-- }

-- local ruff_lsp_opts = {
-- 	cmd = { "ruff-lsp" },
-- 	filetypes = { "python" },
-- 	root_dir = require("lspconfig").util.find_git_ancestor,
-- 	init_options = {
-- 		settings = {
-- 			args = {},
-- 		},
-- 	},
-- }
-- require("lvim.lsp.manager").setup("ruff_lsp", ruff_lsp_opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
	return server ~= "ruff_lsp"
end, lvim.lsp.automatic_configuration.skipped_servers)
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
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- { command = "clang-format", filetypes = { "proto" }, extra_args = { "--style=Google" } },
	{ command = "protolint" },
	{ command = "clang-format", filetypes = { "yang" } },
	{ command = "beautysh", extra_args = { "-i", "2" } },
	{ command = "stylua" },
	-- { command = "yamlfmt" },
	{ command = "ruff" },
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
})

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
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
		-- filetypes = { "javascript", "python" },
	},
	-- {
	-- command = "ruff",
	-- args = { "-n", "-e", "--stdin-filename", "$FILENAME", "-" },
	-- },
})

-- Additional Plugins
lvim.plugins = {
	{ "tpope/vim-unimpaired" },
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y", "v" },
		-- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
		init = function()
			vim.o.timeoutlen = 500
			vim.cmd("xmap gS <Plug>VSurround")
		end,
	},
	{ "tpope/vim-repeat" },
	-- { "folke/tokyonight.nvim" },
	-- {
	-- 	"folke/trouble.nvim",
	-- },
	{
		"ggandor/leap.nvim",
		event = "BufRead",
		keys = { "s", "S" },
		config = function()
			require("leap").setup({
				highlight_unlabeled_phase_one_targets = true,
			})
			require("leap").add_default_mappings()
		end,
	},
	-- {
	-- 	"ggandor/flit.nvim",
	-- 	after = "leap.nvim",
	-- 	config = function()
	-- 		require("flit").setup({
	-- 			keys = { f = "f", F = "F", t = "t", T = "T" },
	-- 			-- A string like "nv", "nvo", "o", etc.
	-- 			labeled_modes = "nvo",
	-- 			multiline = true,
	-- 			-- Like `leap`s similar argument (call-specific overrides).
	-- 			-- E.g.: opts = { equivalence_classes = {} }
	-- 			opts = {},
	-- 		})
	-- 	end,
	-- },
	{
		"ggandor/leap-spooky.nvim",
		after = "leap.nvim",
		config = function()
			require("leap-spooky").setup()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
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
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		lazy = true,
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	},
	{
		"p00f/nvim-ts-rainbow",
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
		"ojroques/nvim-osc52",
		config = function()
			require("osc52").setup({
				silent = true,
			})
			local function copy()
				if vim.v.event.operator == "y" then
					require("osc52").copy_register(vim.v.event.regname)
				end
			end

			vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
		end,
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
		end,
	},
	{
		"vigoux/notifier.nvim",
		event = "BufRead",
		config = function()
			require("notifier").setup({
				-- You configuration here
			})
		end,
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",", -- (Optional) keymap to select the previous selection
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,
						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							-- ['@class.outer'] = '<c-v>', -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = false,
					},
				},
			})
		end,
	},
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		event = "BufRead",
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup({
				auto_enable = true,
				auto_resize_height = true, -- highly recommended enable
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
					show_title = false,
					should_preview_cb = function(bufnr, _)
						local ret = true
						local bufname = vim.api.nvim_buf_get_name(bufnr)
						local fsize = vim.fn.getfsize(bufname)
						if fsize > 100 * 1024 then
							-- skip file size greater than 100k
							ret = false
						elseif bufname:match("^fugitive://") then
							-- skip fugitive buffer
							ret = false
						end
						return ret
					end,
				},
				-- make `drop` and `tab drop` to become preferred
				func_map = {
					drop = "o",
					openc = "O",
					split = "<C-s>",
					tabdrop = "<C-t>",
					-- set to empty string to disable
					tabc = "",
					ptogglemode = "z,",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"junegunn/fzf",
		build = function()
			vim.fn["fzf#install"]()
		end,
	},
	{
		"mhinz/vim-grepper",
		config = function()
			vim.g.grepper = { tools = { "rg", "grep" }, searchreg = 1 }
			vim.cmd(([[
          aug Grepper
              au!
              au User Grepper ++nested %s
          aug END
      ]]):format([[call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': '\%#' . getreg('/')}}})]]))

			-- try `gsiw` under word
			vim.cmd([[
          nmap gp  <plug>(GrepperOperator)
          xmap gp  <plug>(GrepperOperator)
      ]])
		end,
	},
	{
		"chentoast/marks.nvim",
		event = "BufRead",
		config = function()
			require("marks").setup({
				bookmark_0 = {
					sign = "⚑",
					virt_text = "TODO",
					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
					-- defaults to false.
					annotate = false,
				},
				mappings = {
					-- preview = false,
				},
			})
		end,
	},
	{
		"benfowler/telescope-luasnip.nvim",
		lazy = true,
	},
	{ "nvim-treesitter/playground" },
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

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "combos.def",
	callback = function()
		require("nvim-treesitter.highlight").attach(0, "c")
	end,
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
	command = "setlocal filetype=tmux",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.cmd("command! Darker :!darker %")
		vim.cmd("command! Black :!black % --preview")
		vim.cmd("command! Isort :!isort % --profile black")
		vim.cmd(
			"command! Autoflake :!autoflake % --in-place --remove-unused-variables --remove-rhs-for-unused-variables --remove-duplicate-keys"
		)
		vim.cmd("command! AutoflakePlus :!autoflake % --in-place --remove-all-unused-imports")
	end,
})

local function parseParams(text)
	local params = {}

	-- Split the parameter text by comma.
	local paramList = {}
	for param in text:gmatch("[^,]+") do
		table.insert(paramList, param)
	end

	-- Parse each parameter.
	for _, param in ipairs(paramList) do
		-- Extract the parameter name and type using patterns.
		local name = param:match("%s*([%w_]+)$")
		local type = param:match("^%s*(.+)" .. name .. "$")
		type = string.gsub(type, "^%s*(.-)%s*$", "%1")

		-- Add the parameter to the list.
		table.insert(params, { name = name, type = type })
	end

	return params
end

local function log_debug_function()
	vim.api.nvim_command(":normal 0yib])jo")
	local params = vim.fn.getreg('"')
	local parsed = parseParams(params)
	local params_logs = {}
	local names = {}
	for _, value in ipairs(parsed) do
		table.insert(names, value.name)
		if value.type:find("*") then
			table.insert(params_logs, value.name .. "=%p")
		elseif value.type:find("uint") then
			table.insert(params_logs, value.name .. "=%u")
		elseif value.type:find("(int|bool)") then
			table.insert(params_logs, value.name .. "=%d")
		else
			table.insert(params_logs, value.name .. "=%d")
		end
	end
	local result = { "CHEETAH_LOG(DN_LOG_DEBUG" }
	table.insert(result, '"' .. table.concat(params_logs, ", ") .. '"')
	table.insert(result, table.concat(names, ", ") .. ");")
	vim.api.nvim_put({ table.concat(result, ", ") }, "", true, true)
end

vim.api.nvim_create_user_command("LogDebugFunction", log_debug_function, {})
