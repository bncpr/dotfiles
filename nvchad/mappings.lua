local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<C-s>"] = "",
    ["<leader>tt"] = ""
  }
}

M.general = {
  t = {
    ["<C-[>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
    ["<esc>"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
  }
}

M.nvterm = {
  t = {
    ["<space>T"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
    ["<space>V"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
    ["<space>H"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    }
  },
  n = {
    ["<space>T"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
    ["<space>V"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
    ["<space>H"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    }
  }
}

return M
